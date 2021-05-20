import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.checkToken();
    return Scaffold(
      body: Container(),
    );
  }
}
