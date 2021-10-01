import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();

  final RxInt pageRx = 0.obs;
  late final Uri? deepLink;

  List<OnBoardingData> data = [
    OnBoardingData(
      'images/onboarding_1.svg',
      'Watch',
      'Check out shows that reward you on Sator. Watch as you normally would, and then...',
    ),
    OnBoardingData(
      'images/onboarding_2.svg',
      'Play + Earn',
      'While or after watching, enter the matching Sator realm for chat, trivia, games and NFTs.',
    ),
    OnBoardingData(
      'images/onboarding_3.svg',
      'Interact',
      'Utilize SAO to collect NFTs, extend realms, stake, tip, vote and more.',
    ),
  ];

  OnBoardingController() {
    OnBoardingArgument argument = Get.arguments as OnBoardingArgument;
    deepLink = argument.deepLink;
  }

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
    pageRx.value = pageController.page?.round() ?? 0;
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
    Get.offAll(
      () => CreateAccountPage(),
      binding: CreateAccountBinding(),
      arguments: CreateAccountArgument(deepLink),
    );
  }
}

class OnBoardingArgument {
  final Uri? deepLink;

  const OnBoardingArgument(this.deepLink);
}
