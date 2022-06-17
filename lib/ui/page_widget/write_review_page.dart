import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/write_review_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';
import 'package:satorio/util/avatar_list.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/smile_list.dart';

class WriteReviewPage extends GetView<WriteReviewController> {
  final double bodyHeight = max(0.3 * Get.height, 220);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        leading: null,
        actions: [
          Container(
            height: kToolbarHeight,
            width: kToolbarHeight,
            child: InkWell(
              onTap: () => controller.back(),
              child: Icon(
                Icons.close,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Obx(
              () => CachedNetworkImage(
                imageUrl: controller.showEpisodeRx.value.cover,
                cacheKey: controller.showEpisodeRx.value.cover,
                width: Get.width,
                height: bodyHeight + 24,
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
              margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight,
              ),
              width: Get.width,
              height:
                  Get.height - (Get.mediaQuery.padding.top + kToolbarHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Obx(() {
                  switch (controller.stateRx.value) {
                    case WriteReviewState.preview:
                      return _previewWidget();
                    case WriteReviewState.creating:
                    default:
                      return _enterReviewWidget();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _enterReviewWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18 * coefficient,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 18 * coefficient,
                    color: SatorioColor.textBlack,
                  ),
                  SizedBox(
                    width: 12 * coefficient,
                  ),
                  Text(
                    'txt_write_review'.tr,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 13 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'txt_rating'.tr,
                        style: textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: SatorioColor.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => SvgPicture.asset(
                              smile[controller.rateRx.value] ?? '',
                              width: 34 * coefficient,
                              height: 34 * coefficient,
                            ),
                          ),
                          SizedBox(
                            width: 10 * coefficient,
                          ),
                          Obx(
                            () => Text(
                              '${(controller.rateRx.value * 10).toInt()}%',
                              style: textTheme.headline4!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 24 * coefficient,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Obx(
                        () => Slider(
                          onChanged: (value) {
                            controller.rateRx.value = value.toInt();
                          },
                          divisions: (WriteReviewController.maxValue -
                                  WriteReviewController.minValue)
                              .toInt(),
                          min: WriteReviewController.minValue.toDouble(),
                          max: WriteReviewController.maxValue.toDouble(),
                          value: controller.rateRx.value.toDouble(),
                          activeColor: SatorioColor.interactive,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputTextField(
                        controller: controller.titleController,
                        inputTitle: 'txt_title'.tr,
                        hintText: 'txt_enter_title'.tr,
                      ),
                    ),
                    SizedBox(
                      height: 22 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(
                        () => InputTextField(
                          controller: controller.reviewController,
                          inputTitle: 'txt_review'.tr,
                          inputTitleSuffix: 'txt_min_characters'.tr.format([
                            controller.minReviewLength,
                          ]),
                          hintText: 'txt_enter_review'.tr,
                          errorText: controller.isShowReviewErrorRx.value
                              ? '${'txt_enter_review'.tr} ${'txt_min_characters'.tr.format([
                                      controller.minReviewLength,
                                    ])}'
                              : null,
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => ElevatedGradientButton(
                text: 'txt_preview'.tr,
                isEnabled: controller.titleRx.value.isNotEmpty &&
                    controller.reviewRx.value.length >=
                        controller.minReviewLength,
                onPressed: () {
                  controller.toPreview();
                },
              ),
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
        ],
      ),
    );
  }

  Widget _previewWidget() {
    String avatarAsset = controller.profileRx.value!.avatarPath.isNotEmpty
        ? controller.profileRx.value!.avatarPath
        : avatars[0];

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18 * coefficient,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline_rounded,
                    size: 18 * coefficient,
                    color: SatorioColor.textBlack,
                  ),
                  SizedBox(
                    width: 12 * coefficient,
                  ),
                  Text(
                    'txt_preview'.tr,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 13 * coefficient,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ),
                  color: SatorioColor.alice_blue,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            smile[controller.rateRx.value] ?? '',
                            width: 20 * coefficient,
                            height: 20 * coefficient,
                          ),
                          SizedBox(
                            width: 10 * coefficient,
                          ),
                          Text(
                            '${(controller.rateRx.value * 10).toInt()}%',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 12 * coefficient,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                              maxLines: 1,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyText2!.copyWith(
                                color: SatorioColor.textBlack,
                                fontSize: 12 * coefficient,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10 * coefficient,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                      height: 1,
                    ),
                    SizedBox(
                      height: 16 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        controller.titleRx.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline4!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 18 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8 * coefficient,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        controller.reviewRx.value,
                        maxLines: null,
                        style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16 * coefficient,
                    ),
                    Container(
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
                      child: Row(
                        children: [
                          ClipOval(
                              child: AvatarImage(
                            avatarAsset,
                            width: 20,
                            height: 20,
                          )),
                          SizedBox(
                            width: 6 * coefficient,
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.profileRx.value?.displayedName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText2!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15 * coefficient,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'images/like_icon.svg',
                            color: SatorioColor.textBlack,
                          ),
                          SizedBox(
                            width: 8 * coefficient,
                          ),
                          Text(
                            '0',
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 14 * coefficient,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 15 * coefficient,
                          ),
                          SvgPicture.asset(
                            'images/dislike_icon.svg',
                            color: SatorioColor.textBlack,
                          ),
                          SizedBox(
                            width: 8 * coefficient,
                          ),
                          Text(
                            '0',
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 14 * coefficient,
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
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedGradientButton(
              text: 'txt_looks_good'.tr,
              isInProgress: controller.isRequested.value,
              onPressed: () {
                controller.submitReview();
              },
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BorderedButton(
              text: 'txt_looks_bad'.tr,
              borderColor: SatorioColor.interactive,
              textColor: SatorioColor.interactive,
              borderWidth: 3,
              onPressed: () {
                controller.toEditReview();
              },
            ),
          ),
          SizedBox(
            height: 16 * coefficient,
          ),
        ],
      ),
    );
  }
}
