import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/avatar_list.dart';

class QuizLobbyPage extends GetView<QuizLobbyController> {
  final int _randomOffset = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    const double kHeight = 120;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'images/bg/gradient.svg',
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Container(
              height: kHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 33),
                child: Stack(
                  children: [
                    Positioned(
                      top: kHeight / 2,
                      child: InkWell(
                        onTap: () => controller.quizController.back(),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 32,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: kHeight / 1.8),
                      width: Get.mediaQuery.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'txt_challenge_lobby'.tr,
                            style: TextStyle(
                              color: SatorioColor.darkAccent,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.only(top: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                      ),
                      child: Obx(
                        () => ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 28,
                          ),
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.black.withOpacity(0.11),
                          ),
                          itemCount: controller.usersRx.value.length,
                          itemBuilder: (context, index) {
                            PayloadUser payloadUser =
                                controller.usersRx.value[index];
                            return _payloadUserItem(payloadUser, index);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'txt_waiting_players'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: SatorioColor.darkAccent,
                        fontSize: 34.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text(
                    'txt_players_connected'.tr,
                    style: TextStyle(
                      color: SatorioColor.darkAccent,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => Text(
                      '${controller.usersRx.value.length} / ${controller.quizController.challenge.players}',
                      style: TextStyle(
                        color: SatorioColor.darkAccent,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payloadUserItem(PayloadUser payloadUser, int index) {
    int avatarIndex = (index +_randomOffset) % avatars.length;
    return Container(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 12,
          ),
          ClipOval(
            child: SvgPicture.asset(
              avatars[avatarIndex],
              width: 34,
              height: 34,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              payloadUser.username,
              style: TextStyle(
                color: SatorioColor.darkAccent,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
