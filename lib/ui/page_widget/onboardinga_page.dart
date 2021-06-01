import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/onboading_controller.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';

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
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.mediaQuery.padding.top + 12, right: 12),
              child: TextButton(
                onPressed: () => controller.skip(),
                child: Obx(
                  () => Text(
                    'txt_skip'.tr,
                    style: TextStyle(
                      color: controller.data[controller.pageRx.value].textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
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

  Widget _onBoardingDataWidget(OnBoardingData data) {
    return Container(
      color: data.backgroundColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 183),
                Image.asset(
                  data.assetName,
                  height: 164,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(height: 61),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    data.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: data.textColor,
                      fontSize: 34.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 81),
              child: RawMaterialButton(
                elevation: 0,
                onPressed: () => controller.nextOrJoin(),
                fillColor: data.buttonColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(26.0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 48,
                  color: data.backgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
