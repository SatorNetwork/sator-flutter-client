import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

class ShowEpisodesRealmPage extends GetView<ShowEpisodeRealmController> {
  final double kAppBarHeight = 120;
  final double kHeight = 220;

  ShowEpisodesRealmPage(
      ShowDetail showDetail, ShowSeason showSeason, ShowEpisode showEpisode)
      : super() {
    controller.updateData(showDetail, showSeason, showEpisode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(),
    );
  }

  Widget _bodyContent() {
    return Stack(
      children: [
        Obx(
          () => Image.network(
            controller.showEpisodeRx.value?.cover ?? '',
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
        Container(
          height: kHeight,
          child: Stack(
            children: [
              Positioned(
                top: kAppBarHeight / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () => controller.back(),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: kAppBarHeight / 2),
                width: Get.mediaQuery.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.showDetailRx.value?.title ?? '',
                        style: textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontSize: 12.0 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Obx(
                      () => Text(
                        'txt_episode_naming'.tr.format([
                          controller.showSeasonRx.value?.seasonNumber ?? 0,
                          controller.showEpisodeRx.value?.episodeNumber ?? 0,
                          controller.showEpisodeRx.value?.title ?? '',
                        ]),
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: kAppBarHeight / 2,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 50,
                  height: 44,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () => controller.back(),
                            child: SvgPicture.asset('images/chat_icon.svg')),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 24,
                        child: ClipOval(
                          child: Container(
                            height: 20,
                            width: 20,
                            color: SatorioColor.brand,
                            child: Center(
                              child: Text(
                                '55',
                                style: textTheme.bodyText2!.copyWith(
                                  color: Colors.white,
                                  fontSize: 9 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: kHeight / 1.5),
                width: Get.mediaQuery.size.width,
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    Obx(
                      () => Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white.withOpacity(0.6),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Row(
                            children: [
                              Obx(
                                () => controller.isRealmActivatedRx.value ==
                                        false
                                    ? SvgPicture.asset('images/locked_icon.svg')
                                    : SvgPicture.asset(
                                        'images/unlocked_icon.svg'),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    controller.isRealmActivatedRx.value == true
                                        ? '24hrs'
                                        : 'Locked',
                                    style: textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      fontSize: 15 * coefficient,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Status',
                                    style: textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      fontSize: 12 * coefficient,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/sator_logo.svg',
                              color: Colors.black,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '0',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'you',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '3,414.42',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'fans',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/sator_logo.svg',
                              color: Colors.black,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '0',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'you',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '3,414.42',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 15 * coefficient,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'fans',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.black,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomSheetContent() {
    final double minSize = (Get.height - 260) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 48,
                      ),
                      Text(
                        'txt_episode_rating'.tr,
                        style: textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontSize: 24 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          color: SatorioColor.alice_blue,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('images/star_icon.svg'),
                            Text(
                              '9 / 10',
                              style: textTheme.headline5!.copyWith(
                                color: Colors.black,
                                fontSize: 20 * coefficient,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              '5,120 ratings',
                              style: textTheme.bodyText2!.copyWith(
                                color: Colors.black,
                                fontSize: 15 * coefficient,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'txt_reviews'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.back(),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 32,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 260,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 16,
                                ),
                            itemBuilder: (context, index) {
                              return _reviewItem(review);
                            }),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => Text(
                          'txt_challenges'.tr,
                          style: textTheme.headline4!.copyWith(
                            color: controller.isRealmActivatedRx.value == true
                                ? Colors.black
                                : Colors.black.withOpacity(0.4),
                            fontSize: 24 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Obx(() => InkWell(
                                onTap: controller.isRealmActivatedRx.value
                                    ? () {
                                        controller.toChallenge();
                                      }
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                    color: SatorioColor.interactive,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, bottom: 16),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 52,
                                              width: 52,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: Color(0xFF584FC1),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'txt_head'.tr,
                                                  style: textTheme.bodyText1!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 18 * coefficient,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  'txt_head_text'.tr,
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14 * coefficient,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: Container()),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              size: 32,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 45,
                                            right: 45,
                                            top: 21,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Color(0xFF6359E4),
                                              Color(0xFF7C73E8)
                                            ])),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '291',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14 * coefficient,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'players',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14 * coefficient,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '2,130.00 SAO',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14 * coefficient,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'remains',
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14 * coefficient,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Obx(
                            () => controller.isRealmActivatedRx.value == false
                                ? Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.white.withOpacity(0.9),
                                          Colors.white
                                        ])),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Start watching this episode to earn SAO.',
                                          style: textTheme.bodyText2!.copyWith(
                                            color: Colors.black,
                                            fontSize: 13 * coefficient,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        ElevatedGradientButton(
                                          text: 'txt_activate_realm'.tr,
                                          onPressed: () {
                                            controller.toEpisodeRealmDialog();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ),
                          Obx(
                            () => Container(
                              margin: const EdgeInsets.only(top: 180),
                              child: Text(
                                'txt_nfts'.tr,
                                style: textTheme.headline4!.copyWith(
                                  color: controller.isRealmActivatedRx.value ==
                                          true
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.2),
                                  fontSize: 24 * coefficient,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Opacity(
                              opacity:
                                  controller.isRealmActivatedRx.value == true
                                      ? 1
                                      : 0.5,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 230, bottom: 40),
                                height: 366,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 16,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    String img;
                                    String name;
                                    switch (index) {
                                      case 0:
                                        img = 'nfts_1';
                                        name = "Game of Thrones";
                                        break;
                                      case 1:
                                        img = 'nfts_4';
                                        name = "Sopranos";
                                        break;
                                      case 2:
                                        img = 'nfts_5';
                                        name = "Simpsons";
                                        break;
                                      case 3:
                                        img = 'nfts_2';
                                        name = "Breaking Bad";
                                        break;
                                      case 4:
                                        img = 'nfts_3';
                                        name = "Batman and Robin";
                                        break;
                                      default:
                                        img = 'nfts_5';
                                        name = "Simpsons";
                                        break;
                                    }
                                    return _nftsItem(img, name);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))),
      ),
    );
  }

  Widget _nftsItem(String assetName, String name) {
    double width = Get.width - 80;
    double height = 192.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        child: Stack(
          children: [
            Image.asset(
              "images/new/$assetName.png",
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: SatorioColor.lavender_rose,
                      ),
                      child: Text(
                        'Rank #1',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: SatorioColor.alice_blue,
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.only(top: 170),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'An Electric Storm (1/1 NFT + AR physical, 2021)',
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        fontSize: 18 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                  Color(0xFFFFB546),
                                  Color(0xFFFF7246)
                                ])),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          review.userName,
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: Get.mediaQuery.size.width,
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFDBE7FF), Color(0xFFF0F5FF)])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reserve price',
                          style: textTheme.bodyText2!.copyWith(
                            color: Color(0xFF676B79),
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '15.00 ETH',
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 15 * coefficient,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reviewItem(Review review) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      width: Get.mediaQuery.size.width - 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'images/star_icon.svg',
                      height: 22,
                      width: 22,
                    ),
                    Text(
                      review.rating,
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  review.date,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 12 * coefficient,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            color: Colors.black.withOpacity(0.08),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              review.title,
              style: textTheme.bodyText1!.copyWith(
                color: Colors.black,
                fontSize: 18 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                review.text,
                maxLines: 5,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFDBE7FF), Color(0xFFF0F5FF)])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                              Color(0xFFFFB546),
                              Color(0xFFFF7246)
                            ])),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      review.userName,
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('images/like_icon.svg'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      review.likes,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('images/dislike_icon.svg'),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      review.unlikes,
                      style: textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        fontSize: 14 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  final Review review = Review(
      'id',
      '7 / 10',
      '06 June 2021',
      'Something nice to watch',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum lectus semper neque pellentesque, nec molestie elit maximus. Nulla et diam at ante pellentesque ornare. Suspendisse dapibus, erat at ullamcorper dignissim, purus justo blandit diam, id eleifend mi lacus venenatis turpis. Nullam id lacus non odio egestas vehicula. Aliquam vitae vulputate nisl. Sed quis sodales quam, et semper turpis. Etiam iaculis elit a mauris pretium, in suscipit velit auctor. Fusce eu iaculis augue.\nIn hac habitasse platea dictumst. Suspendisse porta fringilla erat eu consequat. Etiam malesuada odio non augue ultricies euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec vel rhoncus eros.',
      'roberto21',
      '2.5M',
      '234');
}
