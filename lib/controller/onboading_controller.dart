import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/domain/entities/onboarding_data.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';
import 'package:satorio/util/onboarding_list.dart';

class OnBoardingController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  static const _autoPageInSec = 6;

  final PageController pageController = PageController();

  final RxInt pageRx = 0.obs;
  late final Uri? deepLink;

  final List<OnBoardingData> data = onBoardings;
  Timer? _timer;

  OnBoardingController() {
    OnBoardingArgument argument = Get.arguments as OnBoardingArgument;
    deepLink = argument.deepLink;
  }

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_listener);

    _startTimer();
  }

  @override
  void onClose() {
    pageController.removeListener(_listener);

    _timer?.cancel();
    _timer = null;

    super.onClose();
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

  void skip() {
    _satorioRepository.markOnBoarded().then((_) {
      Get.offAll(
        () => CreateAccountPage(),
        binding: CreateAccountBinding(),
        arguments: CreateAccountArgument(deepLink),
      );
    });
  }

  void _listener() {
    int pageValue = pageController.page?.round() ?? 0;
    if (pageRx.value != pageValue) {
      pageRx.value = pageValue;
      if (pageValue == data.length - 1) {
        _timer?.cancel();
      } else {
        _startTimer();
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: _autoPageInSec), () {
      nextOrJoin();
    });
  }
}

class OnBoardingArgument {
  final Uri? deepLink;

  const OnBoardingArgument(this.deepLink);
}
