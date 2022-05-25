import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/title_button.dart';
import 'package:satorio/util/extension.dart';

import '../../unity/unity_view_page.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        color: SatorioColor.brand,
        onRefresh: () async {
          controller.refreshHomePage();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: SatorioColor.darkAccent,
                child: Stack(
                  children: [
                    backgroundImage('images/bg/gradient.svg'),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 76, right: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.toProfile();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Center(
                                            child: Obx(() =>
                                                controller.profileRx.value ==
                                                            null ||
                                                        controller
                                                            .profileRx
                                                            .value!
                                                            .avatarPath
                                                            .isEmpty
                                                    ? Image.asset(
                                                        'images/null_avatar.png',
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.fitWidth,
                                                      )
                                                    : AvatarImage(
                                                        controller.profileRx
                                                            .value!.avatarPath,
                                                        width: 50,
                                                        height: 50,
                                                      )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.profileRx.value
                                                  ?.displayedName ??
                                              '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.headline1!.copyWith(
                                              color: SatorioColor.darkAccent,
                                              fontSize: 14.0 * coefficient,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.toWallet();
                              },
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.walletRx.value.length > 0
                                          ? controller
                                              .walletRx.value[0].displayedValue
                                          : '',
                                      style: textTheme.bodyText1!.copyWith(
                                        color: SatorioColor.darkAccent,
                                        fontSize: 18.0 * coefficient,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 160),
                constraints: BoxConstraints(
                  minHeight: Get.height - 160,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Colors.white,
                ),
                child: _contentWithCategories(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentWithCategories(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: InkWell(
            onTap: () {
              controller.toChallenges();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
                color: SatorioColor.interactive,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: Row(
                      children: [
                        Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: SatorioColor.free_speech_blue,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/sator_logo.svg',
                              color: Colors.white,
                              height: 23,
                              width: 23,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controller.quizHeadTitleRx.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1!.copyWith(
                                  color: Colors.white,
                                  fontSize: 18 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Obx(
                              () => Text(
                                controller.quizHeadMessageRx.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.white,
                                  fontSize: 14 * coefficient,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => controller.nftHomeRx.value.length != 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: TitleWithButton(
                    textCode: 'txt_featured_nfts'.tr,
                    onTap: () {
                      controller.toNfts();
                    },
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ),
        Obx(
          () => controller.nftHomeRx.value.length != 0
              ? Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 125 * coefficient,
                  child: Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 12,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: controller.nftHomeRx.value.length,
                      itemBuilder: (context, index) {
                        final NftItem nftItem =
                            controller.nftHomeRx.value[index];
                        return _nftItem(nftItem);
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: TitleWithButton(
            textCode: 'txt_games'.tr,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UnityViewPage()));
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168 * coefficient,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _showItem(new Show("Sator Universe", "Sator Universe", "https://drive.google.com/uc?id=1GJvIMimm14FqeMaCZuaaZ2BJsqWPK34-&export=download", false, false),
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => UnityViewPage()))),
        ),
        _categories(),
        Obx(
          () => controller.allShowsRx.value.length != 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: TitleWithButton(
                    textCode: 'All realms',
                    onTap: () {
                      controller.toAllShows();
                    },
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ),
        Obx(
          () => controller.allShowsRx.value.length != 0
              ? Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 168 * coefficient,
                  child: Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: controller.allShowsRx.value.length,
                      itemBuilder: (context, index) {
                        Show show = controller.allShowsRx.value[index];
                        return _showItem(show);
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ),
        Obx(
          () => controller.rssItemRx.value == null
              ? SizedBox(
                  height: 0,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleWithButton(
                        textCode: 'txt_sator_blog',
                        onTap: () {
                          controller.toBlog();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          controller.toRssItem();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24 * coefficient,
                            vertical: 20 * coefficient,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                SatorioColor.alice_blue,
                                SatorioColor.alice_blue2
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.rssItemRx.value?.pubDate == null
                                    ? ''
                                    : '${DateFormat('MMMM d, yyyy').format(controller.rssItemRx.value!.pubDate!)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.black,
                                  fontSize: 12 * coefficient,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 14 * coefficient,
                              ),
                              Text(
                                controller.rssItemRx.value?.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: textTheme.headline3!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 18 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 18 * coefficient,
                              ),
                              Text(
                                controller.rssItemRx.value?.content?.value
                                        .removeAllHtmlTags() ??
                                    '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: textTheme.headline3!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15 * coefficient,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 18 * coefficient,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.black.withOpacity(0.08),
                              ),
                              SizedBox(
                                height: 18 * coefficient,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'txt_read_more'.tr,
                                      textAlign: TextAlign.start,
                                      style: textTheme.bodyText2!.copyWith(
                                        color: SatorioColor.textBlack,
                                        fontSize: 15 * coefficient,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                    color: SatorioColor.textBlack,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _categories() {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, categoryIndex) => SizedBox(
          height: controller.categoriesRx.value[categoryIndex].shows.length != 0
              ? 16
              : 0,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.categoriesRx.value.length,
        itemBuilder: (context, categoryIndex) {
          ShowCategory category = controller.categoriesRx.value[categoryIndex];
          return Column(
            children: [
              Obx(
                () =>
                    controller.categoriesRx.value[categoryIndex].shows.length !=
                            0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TitleWithButton(
                              textCode: category.title,
                              onTap: () {
                                controller.toShowsCategory(category);
                              },
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
              ),
              Obx(
                () => controller
                            .categoriesRx.value[categoryIndex].shows.length !=
                        0
                    ? Container(
                        margin: const EdgeInsets.only(top: 16),
                        height: 168 * coefficient,
                        child: Obx(
                          () => ListView.separated(
                            separatorBuilder: (context, showIndex) => SizedBox(
                              width: 16,
                            ),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: controller
                                .categoriesRx.value[categoryIndex].shows.length,
                            itemBuilder: (context, showIndex) {
                              Show show = controller.categoriesRx
                                  .value[categoryIndex].shows[showIndex];
                              return _showItem(show);
                            },
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _showItem(Show show, [VoidCallback? onTapCallback]) {
    final width = Get.width - 20 - 32;
    final height = 168.0 * coefficient;
    return InkWell(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback();
        }
        else {
          controller.toShowDetail(show);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: show.cover,
                cacheKey: show.cover,
                width: width,
                height: height,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: SatorioColor.grey,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          show.title,
                          style: textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontSize: 20.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      show.hasNft
                          ? InkWell(
                              onTap: () {
                                controller.toShowNfts(show.id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: SatorioColor.lavender_rose,
                                ),
                                child: Text(
                                  'NFT',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nftItem(final NftItem nftItem) {
    final width = (Get.width - 12 - 2 * 20 - 8) / 2;
    final height = 125 * coefficient;
    return InkWell(
      onTap: () {
        controller.toNftItem(nftItem);
      },
      child: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                nftItem.nftPreview.isEmpty
                    ? nftItem.nftLink
                    : nftItem.nftPreview,
                width: width,
                height: height, //height - 25 * coefficient,
                fit: BoxFit.cover,
              ),
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         width: 18 * coefficient,
            //         height: 18 * coefficient,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [
            //               SatorioColor.razzle_dazzle_rose,
            //               SatorioColor.dodger_blue
            //             ],
            //           ),
            //         ),
            //         child: Center(
            //           child: SvgPicture.asset(
            //             'images/sator_logo.svg',
            //             width: 9 * coefficient,
            //             height: 9 * coefficient,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: 6 * coefficient,
            //       ),
            //       // Expanded(
            //       //   child: Text(
            //       //     '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO',
            //       //     maxLines: 1,
            //       //     overflow: TextOverflow.ellipsis,
            //       //     style: textTheme.bodyText2!.copyWith(
            //       //       color: Colors.black,
            //       //       fontSize: 12.0 * coefficient,
            //       //       fontWeight: FontWeight.w500,
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
