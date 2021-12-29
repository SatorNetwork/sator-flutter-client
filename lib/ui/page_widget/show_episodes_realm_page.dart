import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/data/model/message_model.dart';
import 'package:satorio/domain/entities/message.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/avatar_list.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/smile_list.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ShowEpisodesRealmPage extends GetView<ShowEpisodeRealmController> {
  final double bodyHeight = max(0.3 * Get.height, 220);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                controller.showDetailRx.value.title,
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
                controller.showSeasonRx.value.seasonNumber == 0
                    ? controller.showEpisodeRx.value.title
                    : 'txt_episode_naming'.tr.format(
                        [
                          controller.showSeasonRx.value.seasonNumber,
                          controller.showEpisodeRx.value.episodeNumber,
                          controller.showEpisodeRx.value.title,
                        ],
                      ),
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () => controller.back(),
          child: Icon(
            Icons.chevron_left_rounded,
            size: 32,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            // margin: const EdgeInsets.only(right: 20),
            width: kToolbarHeight,
            height: kToolbarHeight,
            child: Stack(
              children: [
                Center(
                  child: Obx(
                    () => IconButton(
                      onPressed: controller.activationRx.value.isActive
                          ? () => controller.toChatPage()
                          : null,
                      icon: Icon(
                        Icons.question_answer_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.missedMessagesCountRx.value > 0
                      ? Positioned(
                          left: 5,
                          top: 5,
                          child: ClipOval(
                            child: Container(
                              height: 20,
                              width: 20,
                              color: SatorioColor.brand,
                              child: Center(
                                child: Text(
                                  controller.missedMessagesCountRx.value > 9
                                      ? '9+'
                                      : '${controller.missedMessagesCountRx.value}',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontSize: 9 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          )
        ],
      ),
      body: _bodyContent(),
      bottomSheet: _bottomSheetContent(),
    );
  }

  Widget _bodyContent() {
    return Stack(
      children: [
        Obx(
          () => CachedNetworkImage(
            imageUrl: controller.showEpisodeRx.value.cover,
            cacheKey: controller.showEpisodeRx.value.cover,
            height: bodyHeight + 24,
            width: Get.width,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
        Container(
          height: Get.mediaQuery.padding.top + kToolbarHeight + 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
        Container(
          height: bodyHeight,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Get.mediaQuery.padding.top + kToolbarHeight + 20),
                width: Get.mediaQuery.size.width,
                height: 71 * coefficient,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: controller.activationRx.value.isActive
                            ? () {
                                controller.toRealmExpiringBottomSheet();
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  controller.activationRx.value.isActive
                                      ? 'images/unlocked_icon.svg'
                                      : 'images/locked_icon.svg',
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Obx(
                                      () => controller
                                              .activationRx.value.isActive
                                          ? Countdown(
                                              seconds: controller
                                                  .activationRx.value
                                                  .leftTimeInSeconds(),
                                              interval: Duration(seconds: 5),
                                              onFinished: () {
                                                controller.activeTimeExpire();
                                              },
                                              build: (
                                                BuildContext context,
                                                double time,
                                              ) {
                                                return Text(
                                                  'txt_x_left'.tr.format(
                                                    [
                                                      controller
                                                          .activationRx.value
                                                          .leftTimeAsString(),
                                                    ],
                                                  ),
                                                  style: textTheme.bodyText2!
                                                      .copyWith(
                                                    color:
                                                        SatorioColor.textBlack,
                                                    fontSize: 15 * coefficient,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                );
                                              },
                                            )
                                          : Text(
                                              'txt_locked'.tr,
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: SatorioColor.textBlack,
                                                fontSize: 15 * coefficient,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Text(
                                      'txt_status'.tr,
                                      style: textTheme.bodyText2!.copyWith(
                                        color: SatorioColor.textBlack,
                                        fontSize: 12 * coefficient,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/sator_logo.svg',
                              color: SatorioColor.textBlack,
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
                                Obx(
                                  () => Text(
                                    controller
                                        .showEpisodeRx.value.totalRewardsAmount
                                        .toStringAsFixed(2),
                                    style: textTheme.bodyText2!.copyWith(
                                      color: SatorioColor.textBlack,
                                      fontSize: 15 * coefficient,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_sao_earned'.tr,
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'images/active.svg',
                              color: SatorioColor.textBlack,
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
                                Obx(
                                  () => Text(
                                    controller.showEpisodeRx.value.activeUsers
                                        .toString(),
                                    style: textTheme.bodyText2!.copyWith(
                                      color: SatorioColor.textBlack,
                                      fontSize: 15 * coefficient,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  'txt_active'.tr.toLowerCase(),
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 12 * coefficient,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //TODO: uncomment
                    // Container(
                    //   margin: EdgeInsets.only(right: 16),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(8),
                    //     ),
                    //     color: Colors.white.withOpacity(0.6),
                    //   ),
                    //   padding: EdgeInsets.all(16),
                    //   child: Center(
                    //     child: Row(
                    //       children: [
                    //         SvgPicture.asset(
                    //           'images/profile.svg',
                    //           color: SatorioColor.textBlack,
                    //           height: 20,
                    //           width: 20,
                    //         ),
                    //         SizedBox(
                    //           width: 16,
                    //         ),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           mainAxisSize: MainAxisSize.max,
                    //           children: [
                    //             Text(
                    //               '152',
                    //               style: textTheme.bodyText2!.copyWith(
                    //                 color: SatorioColor.textBlack,
                    //                 fontSize: 15 * coefficient,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //             Expanded(
                    //               child: Container(),
                    //             ),
                    //             Text(
                    //               'txt_ranking'.tr.toLowerCase(),
                    //               style: textTheme.bodyText2!.copyWith(
                    //                 color: SatorioColor.textBlack,
                    //                 fontSize: 12 * coefficient,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
    final double minSize = (Get.height - bodyHeight) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) => LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: controller.activationRx.value.isActive
                      ? ScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24 * coefficient,
                        ),
                        Obx(
                          () => controller.showEpisodeRx.value.watch.isEmpty
                              ? SizedBox(
                                  height: 0,
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: BorderedButton(
                                    text: 'txt_watch'.tr,
                                    textColor: SatorioColor.interactive,
                                    backgroundColor: Colors.white,
                                    borderColor: SatorioColor.interactive,
                                    borderWidth: 2,
                                    onPressed: () {
                                      controller.watchVideo();
                                    },
                                  ),
                                ),
                        ),
                        Obx(
                          () => SizedBox(
                            height: controller.showEpisodeRx.value.watch.isEmpty
                                ? 0
                                : 32,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () => controller.toChatPage(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'txt_chat'.tr,
                                      style: textTheme.headline4!.copyWith(
                                        color: SatorioColor.textBlack,
                                        fontSize: 24 * coefficient,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      size: 32 * coefficient,
                                      color: SatorioColor.textBlack,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height:
                                      controller.isMessagesRx.value ? 148 : 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(13),
                                    ),
                                    color: SatorioColor.alice_blue,
                                  ),
                                  child: SingleChildScrollView(
                                    controller: controller.scrollController,
                                    reverse: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(13),
                                      ),
                                      child:
                                          controller.isMessagesRx.value == true
                                              ? _messageList()
                                              : _emptyMessages(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'txt_play'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              controller.toChallenge();
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
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color:
                                                SatorioColor.free_speech_blue,
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
                                              style:
                                                  textTheme.bodyText1!.copyWith(
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
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w400,
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
                                          SatorioColor.medium_slate_blue,
                                          SatorioColor.medium_slate_blue_2
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '291',
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'txt_players'.tr.toLowerCase(),
                                              style:
                                                  textTheme.bodyText2!.copyWith(
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
                                              style:
                                                  textTheme.bodyText2!.copyWith(
                                                color: Colors.white,
                                                fontSize: 14 * coefficient,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'txt_remains'.tr.toLowerCase(),
                                              style:
                                                  textTheme.bodyText2!.copyWith(
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
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'txt_rate'.tr,
                            style: textTheme.headline4!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 24 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(13),
                              ),
                              color: SatorioColor.alice_blue,
                            ),
                            child: Obx(
                              () => controller.showEpisodeRx.value.rating == 0
                                  ? Center(
                                      child: Text(
                                        'txt_null_rate'.tr,
                                        style: textTheme.bodyText2!.copyWith(
                                          color: SatorioColor.interactive,
                                          fontSize: 14 * coefficient,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Obx(
                                          () => controller.showEpisodeRx.value
                                                      .rating >
                                                  1
                                              ? SvgPicture.asset(
                                                  smile[controller.showEpisodeRx
                                                          .value.rating
                                                          .toInt()] ??
                                                      '',
                                                  width: 30 * coefficient,
                                                )
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                        ),
                                        Obx(
                                          () => SizedBox(
                                            width: controller.showEpisodeRx
                                                        .value.rating >
                                                    1
                                                ? 10 * coefficient
                                                : 0,
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            '${(controller.showEpisodeRx.value.rating * 10).toInt()}%',
                                            style:
                                                textTheme.headline5!.copyWith(
                                              color: SatorioColor.textBlack,
                                              fontSize: 20 * coefficient,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Obx(
                                          () => Text(
                                            'txt_ratings'.tr.format(
                                              [
                                                controller.showEpisodeRx.value
                                                    .ratingsCount
                                              ],
                                            ),
                                            style:
                                                textTheme.bodyText2!.copyWith(
                                              color: SatorioColor.textBlack,
                                              fontSize: 15 * coefficient,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              controller.toRateBottomSheet();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(13),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    SatorioColor.alice_blue2,
                                    SatorioColor.alice_blue,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  controller.showSeasonRx.value.seasonNumber ==
                                          0
                                      ? 'txt_rate_content'.tr
                                      : 'txt_rate_episode'.tr,
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.interactive,
                                    fontSize: 14 * coefficient,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              controller.toReviewsPage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'txt_review'.tr,
                                  style: textTheme.headline4!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 24 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => controller.reviewsRx.value.isEmpty
                              ? _emptyReviews()
                              : _reviews(controller.reviewsRx.value),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BorderedButton(
                            text: 'txt_write_review'.tr,
                            borderColor: SatorioColor.interactive,
                            textColor: SatorioColor.interactive,
                            borderWidth: 3,
                            onPressed: () {
                              controller.toWriteReview();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              'txt_earn_sao_upvoted'.tr,
                              style: textTheme.bodyText1!.copyWith(
                                color: SatorioColor.interactive,
                                fontSize: 14 * coefficient,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              if (controller.nftItemsRx.value.isEmpty)
                                controller.toNftsMarketplace();
                              else
                                controller.toNftList();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'txt_collect'.tr,
                                  style: textTheme.headline4!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 24 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 32 * coefficient,
                                  color: SatorioColor.textBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => controller.nftItemsRx.value.isEmpty
                              ? _emptyNfts()
                              : _nftItems(controller.nftItemsRx.value),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!controller.activationRx.value.isActive)
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.25),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(
                        () => Text(
                          controller.showEpisodeRx.value.hint.isEmpty
                              ? 'txt_start_watching_earn_sao'.tr
                              : controller.showEpisodeRx.value.hint,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 13 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => ElevatedGradientButton(
                          text: 'txt_unlock_realm'.tr,
                          isInProgress: controller.isRequestedForUnlock.value,
                          onPressed: () {
                            controller.toEpisodeRealmDialog();
                          },
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: controller.showEpisodeRx.value.watch.isEmpty
                              ? 0
                              : 8 * coefficient,
                        ),
                      ),
                      Obx(
                        () => controller.showEpisodeRx.value.watch.isEmpty
                            ? SizedBox(
                                height: 0,
                              )
                            : BorderedButton(
                                text: 'txt_watch'.tr,
                                textColor: SatorioColor.interactive,
                                backgroundColor: Colors.white,
                                borderColor: SatorioColor.interactive,
                                borderWidth: 2,
                                onPressed: () {
                                  controller.watchVideo();
                                },
                              ),
                      ),
                      Expanded(
                        child: Container(),
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

  Widget _emptyNfts() {
    return InkWell(
      onTap: () {
        controller.toNftsMarketplace();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
          color: SatorioColor.alice_blue,
        ),
        height: 60 * coefficient,
        child: Center(
          child: Text(
            'txt_null_nfts'.tr,
            textAlign: TextAlign.center,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.interactive,
              fontSize: 14 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nftItems(List<NftItem> nftItems) {
    return Container(
      height: 396 * coefficient,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => SizedBox(
          width: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: controller.nftItemsRx.value.length,
        itemBuilder: (context, index) {
          final NftItem nftItem = controller.nftItemsRx.value[index];
          return _nftsItem(nftItem);
        },
      ),
    );
  }

  Widget _nftsItem(final NftItem nftItem) {
    double width = Get.width - 50;
    double height = 192.0 * coefficient;
    return InkWell(
      onTap: () {
        controller.toNftItem(nftItem);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                nftItem.imageLink,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  color: SatorioColor.alice_blue,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          nftItem.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 18 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          //TODO: uncomment
                          // Container(
                          //   height: 20,
                          //   width: 20,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     gradient: LinearGradient(
                          //       begin: Alignment.topRight,
                          //       end: Alignment.bottomLeft,
                          //       colors: [
                          //         SatorioColor.yellow_orange,
                          //         SatorioColor.tomato,
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 6,
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     'Joe',
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: textTheme.bodyText2!.copyWith(
                          //       color: SatorioColor.textBlack,
                          //       fontSize: 15 * coefficient,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.mediaQuery.size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [SatorioColor.alice_blue2, SatorioColor.alice_blue],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'txt_current_price'.tr,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.comet,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${nftItem.buyNowPrice.toStringAsFixed(2)} SAO',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w600,
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

  final List<Color> _colors = [
    SatorioColor.lavender_rose,
    SatorioColor.mona_lisa,
    SatorioColor.light_sky_blue
  ];

  Widget _showMessage(Message message, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${message.fromUserName}: ',
                      style: textTheme.bodyText2!.copyWith(
                        color: color,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: message.text,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 12 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
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
    );
  }

  Widget _messageList() {
    ScrollController _controller = ScrollController();
    return FirebaseAnimatedList(
      padding: EdgeInsets.all(17),
      controller: _controller,
      shrinkWrap: true,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = MessageModel.fromJson(json);
        Color color = _colors[index % _colors.length];
        return _showMessage(message, color);
      },
    );
  }

  Widget _reviews(List<Review> reviews) {
    List<Widget> reviewsList =
        reviews.map((review) => _reviewItem(review)).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: reviewsList,
      ),
    );
  }

  Widget _emptyReviews() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(13),
        ),
        color: SatorioColor.alice_blue,
      ),
      height: 60 * coefficient,
      child: Center(
        child: Text(
          'txt_null_reviews'.tr,
          style: textTheme.bodyText2!.copyWith(
            color: SatorioColor.interactive,
            fontSize: 14 * coefficient,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _reviewItem(Review review) {
    final double reviewContainerHeight = 190.0 * coefficient;

    String avatarAsset =
        review.userAvatar.isNotEmpty ? review.userAvatar : avatars[0];

    final RxBool isExpandedRx = false.obs;

    return Obx(
      () => InkWell(
        onTap: () {
          if (review.review.length < 150) return;
          isExpandedRx.toggle();
        },
        child: Container(
          margin: EdgeInsets.only(right: 12),
          height: isExpandedRx.value ? null : reviewContainerHeight,
          padding: EdgeInsets.only(bottom: 16, top: 16),
          width: Get.mediaQuery.size.width - 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
            color: SatorioColor.alice_blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      smile[review.rating] ?? '',
                      width: 24 * coefficient,
                      height: 24 * coefficient,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        review.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Text(
                  review.review,
                  maxLines: isExpandedRx.value ? 1000 : 4,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              isExpandedRx.value
                  ? Container()
                  : Spacer(
                      flex: 4,
                    ),
              Container(
                padding: EdgeInsets.only(top: 16, left: 20, right: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SatorioColor.alice_blue2,
                      SatorioColor.alice_blue,
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: AvatarImage(
                      avatarAsset,
                      width: 20,
                      height: 20,
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        review.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    //TODO: uncomment
                    // SvgPicture.asset(
                    //   'images/like_icon.svg',
                    //   color: SatorioColor.textBlack,
                    // ),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    // Text(
                    //   review.likes.toString(),
                    //   style: textTheme.bodyText2!.copyWith(
                    //     color: SatorioColor.textBlack,
                    //     fontSize: 14 * coefficient,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    // Container(
                    //   height: 24,
                    //   width: 24,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: SatorioColor.interactive,
                    //   ),
                    //   child: Center(
                    //     child: SvgPicture.asset(
                    //       'images/sator_logo.svg',
                    //       width: 12,
                    //       height: 12,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 4,
                    // ),
                    // Text(
                    //   'txt_tip'.tr,
                    //   style: textTheme.bodyText2!.copyWith(
                    //     color: SatorioColor.interactive,
                    //     fontSize: 14 * coefficient,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyMessages() {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('images/ico_no_message.svg'),
          SizedBox(
            width: 10,
          ),
          Text(
            'txt_no_messages'.tr,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.interactive,
              fontSize: 14 * coefficient,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
