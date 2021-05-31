import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';

class QuizCounterPage extends GetView<QuizCounterController> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: _buildWidgetsTree(context, index),
      ),
    );
  }

  Widget _buildWidgetsTree(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildCountScreen('gradient_challenge_splash', 'count_3');
      case 1:
        return _buildCountScreen(
            'gradient_challenge_splash_reversed', 'count_2');
      case 2:
        return _buildCountScreen('gradient_challenge_splash', 'count_1');
      case 3:
        return _buildCountScreen(
            'gradient_challenge_splash_reversed', 'count_start');
      default:
        return Container(
          color: Colors.white,
        );
    }
  }

  Widget _buildCountScreen(String bgImageName, String countImageName) {
    return Stack(
      children: [
        SvgPicture.asset(
          'images/bg/$bgImageName.svg',
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Center(
          child: Image.asset(
            'images/$countImageName.png',
            width: Get.width,
            fit: countImageName == 'count_start' ? BoxFit.fitWidth : null,
          ),
        ),
      ],
    );
  }
}
