import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/onboading_controller.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => controller.skip(),
            child: Text(
              'txt_skip'.tr,
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.interactive,
                fontSize: 17 * coefficient,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'images/bg/gradient_challenge_timer.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          PageView.builder(
            itemCount: controller.data.length,
            controller: controller.pageController,
            itemBuilder: (context, index) =>
                _onBoardingDataWidget(controller.data[index]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 64,
                left: 20,
                right: 20,
              ),
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.data.length,
                    effect: ExpandingDotsEffect(
                        offset: 0,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 2,
                        dotColor: SatorioColor.link_water,
                        activeDotColor: SatorioColor.interactive),
                  ),
                  SizedBox(
                    height: 21 * coefficient,
                  ),
                  Obx(
                    () => ElevatedGradientButton(
                      text: _buttonText(controller.pageRx.value),
                      onPressed: () {
                        controller.nextOrJoin();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _onBoardingDataWidget(OnBoardingData data) {
    return Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top + kToolbarHeight),
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              data.assetName,
              height: 300 * coefficient,
            ),
          ),
          SizedBox(
            height: 32 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'txt_how_it_works'.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: SatorioColor.interactive,
                fontSize: 12.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              data.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 34.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 18 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              data.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: SatorioColor.textBlack,
                fontSize: 17.0 * coefficient,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buttonText(int page) {
    switch (page) {
      case 2:
        return 'txt_enter_satorverse'.tr;
      default:
        return 'txt_next'.tr;
    }
  }
}
