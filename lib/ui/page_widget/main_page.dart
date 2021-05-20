import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Container(),
    );
  }
}
