import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuzzleImageSampleBottomSheet extends StatelessWidget {
  const PuzzleImageSampleBottomSheet(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  final Uint8List imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Stack(
          children: [
            Positioned(
              top: Get.mediaQuery.padding.top,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox.square(
                dimension: Get.width - 2 * 20,
                child: Image.memory(
                  imageUrl,
                  width: Get.width - 2 * 20,
                  height: Get.width - 2 * 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
