import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ChallengePage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'txt_challenge'.tr,
          style: TextStyle(
              color: SatorioColor.darkAccent,
              fontSize: 22.0,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        separatorBuilder: (context, index) => SizedBox(
          height: 24,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => _challengeItem(),
      ),
    );
  }

  Widget _challengeItem() {
    return Container(
      height: 168,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: NetworkImage('https://picsum.photos/400/168'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                'Peaky Blinders'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Random().nextBool()
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'New episode'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
