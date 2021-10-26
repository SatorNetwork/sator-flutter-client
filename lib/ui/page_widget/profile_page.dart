import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ProfilePage extends GetView<ProfileController> {
  final double nftsLargestImageSize =
      (Get.width - 2 * 20 - 16 * coefficient) / 2;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: SatorioColor.brand,
      onRefresh: () async {
        controller.refreshPage();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
            width: Get.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100 * coefficient,
                  height: 72 * coefficient,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => {controller.toSelectAvatar()},
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(16 * coefficient),
                            child: Obx(
                              () => SvgPicture.asset(
                                controller.profileRx.value?.avatarPath ?? '',
                                width: 72 * coefficient,
                                height: 72 * coefficient,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 40 * coefficient,
                          height: 40 * coefficient,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: SatorioColor.magic_mint,
                                width: 3 * coefficient),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Image.asset(
                              'images/tmp_shuriken.png',
                              height: 24 * coefficient,
                              width: 24 * coefficient,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.profileRx.value?.displayedName ?? '',
                            style: textTheme.headline6!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 18.0 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.toNonWorkingFeatureDialog();
                            //TODO: uncomment
                            // controller.getReferralCode();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(24, 24),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            primary: SatorioColor.brand,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'txt_invite_friends'.tr.toUpperCase(),
                            style: textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                              fontSize: 12.0 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    SatorIcons.exit,
                    size: 24,
                  ),
                  onPressed: () {
                    controller.toLogoutDialog();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (controller.nftItemsRx.value.isEmpty)
                              controller.toBuyNfts();
                            else
                              controller.toMyNfts();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 28, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'txt_nfts'.tr,
                                  style: textTheme.headline3!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 24.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                        _nftsBlock(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 32,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'txt_your_activity'.tr,
                                style: textTheme.headline3!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 24.0 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 32 * coefficient,
                                color: SatorioColor.textBlack,
                              )
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8 * coefficient,
                          ),
                          itemCount: _activities.length,
                          itemBuilder: (context, index) {
                            ActivitySimpleTmp activity = _activities[index];
                            return _activityItem(activity);
                          },
                        ),
                        InkWell(
                          onTap: () =>
                              controller.activatedRealmsRx.value.length != 0
                                  ? controller.toActiveRealmsPage()
                                  : {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 28, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'txt_realms_open'.tr,
                                  style: textTheme.headline3!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 24.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                        _activatedRealms(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 28, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'txt_badges'.tr,
                                style: textTheme.headline3!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 24.0 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 32 * coefficient,
                                color: SatorioColor.textBlack,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 121 * coefficient,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 12 * coefficient,
                            ),
                            itemCount: _badges.length,
                            itemBuilder: (context, index) {
                              BadgeTmp badge = _badges[index];
                              return _badgeItem(badge);
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () => controller.reviewsRx.value.length != 0
                              ? controller.toReviewsPage()
                              : {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 28, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'txt_reviews'.tr,
                                  style: textTheme.headline3!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 24.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                        Obx(() => _reviews(controller.reviewsRx.value)),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _nftsBlock() {
    return Obx(
      () {
        List<NftItem> nfts = controller.nftItemsRx.value;
        return nfts.isEmpty
            ? InkWell(
                onTap: () {
                  controller.toBuyNfts();
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(17 * coefficient)),
                    color: SatorioColor.alice_blue,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'txt_you_havent_nfts'.tr,
                        style: textTheme.headline3!.copyWith(
                          color: SatorioColor.darkAccent,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: nftsLargestImageSize + 21 * coefficient,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: nfts.length > 0
                                ? InkWell(
                                    onTap: () {
                                      controller.toNftItem(nfts[0]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(17 * coefficient),
                                      ),
                                      child: Image.network(
                                        nfts[0].imageLink,
                                        width: nftsLargestImageSize,
                                        height: nftsLargestImageSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: nftsLargestImageSize,
                                    height: nftsLargestImageSize,
                                  ),
                          ),
                          SizedBox(
                            width: 16 * coefficient,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: nfts.length > 1
                                      ? InkWell(
                                          onTap: () {
                                            controller.toNftItem(nfts[1]);
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(17 * coefficient),
                                            ),
                                            child: Image.network(
                                              nfts[1].imageLink,
                                              width: nftsLargestImageSize,
                                              height: nftsLargestImageSize,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: nftsLargestImageSize,
                                          height: nftsLargestImageSize,
                                        ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 16 * coefficient,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: nfts.length > 2
                                              ? InkWell(
                                                  onTap: () {
                                                    controller
                                                        .toNftItem(nfts[2]);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          17 * coefficient),
                                                    ),
                                                    child: Image.network(
                                                      nfts[2].imageLink,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                        SizedBox(
                                          width: 15 * coefficient,
                                        ),
                                        Expanded(
                                          child: nfts.length > 3
                                              ? InkWell(
                                                  onTap: () {
                                                    controller
                                                        .toNftItem(nfts[3]);
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          17 * coefficient),
                                                    ),
                                                    child: Image.network(
                                                      nfts[3].imageLink,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      nfts.length > 0 ? nfts[0].name : '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline3!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 15.0 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _badgeItem(BadgeTmp badge) {
    return InkWell(
      onTap: () {
        controller.toNonWorkingFeatureDialog();
      },
      child: Container(
        height: 121 * coefficient,
        width: 100 * coefficient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100 * coefficient,
              height: 100 * coefficient,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(17 * coefficient)),
                color: SatorioColor.alice_blue,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      badge.asset,
                      width: 60 * coefficient,
                      height: 60 * coefficient,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (badge.count > 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 6 * coefficient,
                            horizontal: 8 * coefficient),
                        child: Text(
                          badge.count.toString(),
                          style: textTheme.headline6!.copyWith(
                            color: SatorioColor.interactive,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              badge.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.interactive,
                fontSize: 14.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activatedRealms() {
    return Obx(
      () => SizedBox(
        height: controller.activatedRealmsRx.value.length != 0
            ? 180
            : 60 * coefficient,
        child: controller.activatedRealmsRx.value.length != 0
            ? ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) => SizedBox(
                  width: 16 * coefficient,
                ),
                itemCount: controller.activatedRealmsRx.value.length,
                itemBuilder: (context, index) {
                  ActivatedRealm? realm =
                      controller.activatedRealmsRx.value[index];
                  return _realmItem(realm!);
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _emptyState('txt_null_realms'.tr),
              ),
      ),
    );
  }

  Widget _activityItem(ActivitySimpleTmp activity) {
    return InkWell(
      onTap: () {
        controller.toNonWorkingFeatureDialog();
      },
      child: Container(
        height: 74 * coefficient,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
          color: SatorioColor.alice_blue,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110 * coefficient,
              padding: EdgeInsets.symmetric(horizontal: 13 * coefficient),
              child: Center(
                child: Image.asset(
                  activity.asset,
                ),
              ),
            ),
            VerticalDivider(
              width: 1,
              color: Colors.black.withOpacity(0.08),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * coefficient),
                child: Text(
                  activity.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.darkAccent,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _realmItem(ActivatedRealm realm) {
    final double itemWidth = Get.width - 2 * 20 - 16 * coefficient;
    final double borderWidth = 5 * coefficient;

    return InkWell(
      onTap: () {
        controller.toEpisodeDetail(realm);
      },
      child: Container(
        width: itemWidth,
        height: 180 * coefficient,
        decoration: BoxDecoration(
          border: Border.all(
            color: SatorioColor.interactive,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16 * coefficient)),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(16 * coefficient - borderWidth)),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CachedNetworkImage(
                imageUrl: realm.cover,
                cacheKey: realm.cover,
                width: Get.width,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: SatorioColor.darkAccent,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: itemWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * coefficient - borderWidth,
                    vertical: 20 * coefficient - borderWidth,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        realm.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        realm.showTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontSize: 18.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState(String message) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
          color: SatorioColor.alice_blue,
        ),
        height: 60 * coefficient,
        child: Center(
          child: Text(
            message,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.interactive,
              fontSize: 14 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }

  Widget _reviews(List<Review?> reviews) {
    List<Widget> reviewsList =
        reviews.map((review) => _reviewItem(review)).toList();

    return reviews.length != 0
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviewsList,
              ),
            ),
          )
        : _emptyState('txt_null_reviews'.tr);
  }

  Widget _reviewItem(Review? review) {
    final double reviewContainerHeight = 230.0 * coefficient;
    final double itemWidth = Get.width - 20 - 2 * 16 * coefficient;
    final EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 16 * coefficient, vertical: 2);
    final formatter = DateFormat('dd MMMM yyyy');

    Rx<bool> isExpandedRx = Rx(false);

    return Obx(
      () => InkWell(
        onTap: () {
          if (review!.review.length < 70) return;
          isExpandedRx.value = !isExpandedRx.value;
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          height: isExpandedRx.value ? null : reviewContainerHeight,
          width: itemWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(17 * coefficient)),
            color: SatorioColor.alice_blue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 44 * coefficient,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.08),
                      width: 1 * coefficient,
                    ),
                  ),
                ),
                child: Padding(
                  padding: padding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 22 * coefficient,
                        color: SatorioColor.interactive,
                      ),
                      SizedBox(
                        width: 4 * coefficient,
                      ),
                      Text(
                        '${review!.rating}',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 12.0 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${formatter.format(review.createdAt!)}',
                          textAlign: TextAlign.end,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 12.0 * coefficient,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: Text(
                  '${review.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline6!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 18.0 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: Text(
                  '${review.review}',
                  maxLines: isExpandedRx.value ? 1000 : 4,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              isExpandedRx.value
                  ? Container()
                  : Spacer(
                      flex: 5,
                    ),
              Container(
                height: 60 * coefficient,
                width: itemWidth,
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(17 * coefficient),
                  ),
                  // color: Colors.red
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [SatorioColor.alice_blue2, SatorioColor.alice_blue],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 20 * coefficient,
                      height: 20 * coefficient,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            SatorioColor.yellow_orange,
                            SatorioColor.tomato,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6 * coefficient,
                    ),
                    Expanded(
                      child: Text(
                        '${review.userName}',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15.0 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.thumb_up_rounded,
                      size: 20 * coefficient,
                      color: SatorioColor.interactive,
                    ),
                    SizedBox(
                      width: 8 * coefficient,
                    ),
                    Text(
                      '${review.likes}k',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 14.0 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 24 * coefficient,
                    ),
                    Icon(
                      Icons.thumb_down_rounded,
                      size: 20 * coefficient,
                      color: SatorioColor.textBlack,
                    ),
                    SizedBox(
                      width: 8 * coefficient,
                    ),
                    Text(
                      '${review.unlikes}',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 14.0 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<BadgeTmp> _badges = [
    BadgeTmp('images/tmp_badge_1.png', 'Genesis', 0),
    BadgeTmp('images/tmp_badge_2.png', 'Big Binger', 2),
    BadgeTmp('images/tmp_badge_3.png', 'Speed Demon', 4),
    BadgeTmp('images/tmp_badge_4.png', 'Collector', 0),
  ];

  final List<ActivitySimpleTmp> _activities = [
    ActivitySimpleTmp(
      'images/tmp_stranger_things.png',
      'You scored top 50 in S1. E4 realm.',
    ),
    ActivitySimpleTmp(
      'images/tmp_breaking_bad.png',
      'Finished all of 2nd season.',
    ),
    ActivitySimpleTmp(
      'images/tmp_stranger_things.png',
      'Beat @jerry24 in 1-1 super challenge.',
    ),
    ActivitySimpleTmp(
      'images/tmp_stranger_things.png',
      'Beat @jerry in 1-1 super challenge.',
    ),
  ];
}

class BadgeTmp {
  const BadgeTmp(this.asset, this.name, this.count);

  final String asset;
  final String name;
  final int count;
}

class ActivitySimpleTmp {
  const ActivitySimpleTmp(this.asset, this.text);

  final String asset;
  final String text;
}
