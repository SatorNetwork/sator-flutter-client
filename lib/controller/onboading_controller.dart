import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

  final RxInt pageRx = 0.obs;

  List<OnBoardingData> data = [
    OnBoardingData(
      'images/on_boarding1.png',
      'Challenge your friends',
      SatorioColor.royal_blue,
      Colors.white,
      SatorioColor.carnation_pink,
    ),
    OnBoardingData(
      'images/on_boarding2.png',
      'Challenge your friends',
      SatorioColor.carnation_pink,
      Colors.white,
      Colors.white,
    ),
    OnBoardingData(
      'images/on_boarding3.png',
      'Challenge your friends',
      Colors.white,
      SatorioColor.textBlack,
      SatorioColor.carnation_pink,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_listener);
  }

  @override
  void onClose() {
    pageController.removeListener(_listener);
    super.onClose();
  }

  _listener() {
    pageRx.value = pageController.page.round();
  }

  void nextOrJoin() {
    if (pageRx.value == data.length - 1) {
      skip();
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  skip() {
    Get.off(() => CreateAccountPage(), binding: CreateAccountBinding());
  }
}
