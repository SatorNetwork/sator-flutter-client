import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final RxBool isLastPage = false.obs;

  List<OnBoardingData> data = [
    OnBoardingData(
      'Onboarding 1',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'images/on_boarding.svg',
    ),
    OnBoardingData(
      'Onboarding 2',
      'Maecenas lacinia efficitur dictum. Pellentesque eu nulla sit amet mi semper vestibulum vel et ligula.',
      'images/on_boarding.svg',
    ),
    OnBoardingData(
      'Onboarding 3',
      'Curabitur posuere, dolor quis commodo vulputate, odio nunc maximus ex, sed faucibus elit ex',
      'images/on_boarding.svg',
    ),
  ];

  @override
  void onInit() {
    pageController.addListener(_listener);
  }

  @override
  void onClose() {
    pageController.removeListener(_listener);
  }

  _listener() {
    final page = pageController.page.round();
    isLastPage.value = page == data.length - 1;
  }

  void nextOrJoin() {
    if (isLastPage.value) {
      Get.off(() => CreateAccountPage(), binding: CreateAccountBinding());
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }
}
