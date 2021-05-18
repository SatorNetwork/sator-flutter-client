import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.checkSomething();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Some title'),
      // ),
      body: Container(),
    );
  }
}
