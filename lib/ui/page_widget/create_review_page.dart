import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/create_review_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/smile_list.dart';

class CreateReviewPage extends GetView<CreateReviewController> {
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
              () => Image.network(
                controller.showEpisodeRx.value.cover,
                height: max(0.3 * Get.height, 220) + 24,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
                child: SingleChildScrollView(
                  child: _enterReviewWidget(),
                ),
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
          ),
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
                divisions: (CreateReviewController.maxValue -
                        CreateReviewController.minValue)
                    .toInt(),
                min: CreateReviewController.minValue.toDouble(),
                max: CreateReviewController.maxValue.toDouble(),
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
            child: InputTextField(
              controller: controller.reviewController,
              inputTitle: 'txt_review'.tr,
              hintText: 'txt_enter_review'.tr,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              // maxLines: 8,
            ),
          ),
          SizedBox(
            height: 32 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => ElevatedGradientButton(
                  text: 'txt_preview'.tr,
                  isEnabled: controller.titleRx.value.isNotEmpty &&
                      controller.reviewRx.value.isNotEmpty),
            ),
          ),
          SizedBox(
            height: 32 * coefficient,
          ),
        ],
      ),
    );
  }
}
