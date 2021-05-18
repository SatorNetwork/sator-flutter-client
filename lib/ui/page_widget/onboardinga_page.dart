import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/onboading_controller.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: controller.data.length,
            controller: controller.pageController,
            itemBuilder: (context, index) =>
                _onBoardingDataWidget(controller.data[index]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: controller.data.length,
                effect: ExpandingDotsEffect(
                  offset: 0,
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 2,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => controller.nextOrJoin(),
              child: Obx(() => Text(
                    controller.isLastPage.value ? 'txt_join'.tr : 'txt_next'.tr,
                    style: textTheme.bodyText1
                        .copyWith(color: SatorioColor.darkAccent),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _onBoardingDataWidget(OnBoardingData data) {
    return Column(
      children: [
        SvgPicture.asset(
          data.assetName,
          height: Get.height * 0.6,
        ),
        Text(
          data.title,
          style: textTheme.headline2.copyWith(color: SatorioColor.darkAccent),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style: textTheme.subtitle2.copyWith(color: SatorioColor.darkAccent),
          ),
        ),
      ],
    );
  }
}
