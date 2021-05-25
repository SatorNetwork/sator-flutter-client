import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ChallengePage extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Hold on for dear life',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: SatorioColor.lavender_rose,
                    ),
                    child: Text(
                      'New'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
