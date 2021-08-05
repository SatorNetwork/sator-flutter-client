import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/util/avatar_list.dart';

class ProfilePage extends GetView<ProfileController> {
  final int avatarIndex = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
          width: Get.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100 * coefficient,
                height: 72 * coefficient,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16 * coefficient),
                        child: SvgPicture.asset(
                          avatars[avatarIndex],
                          width: 72 * coefficient,
                          height: 72 * coefficient,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 40 * coefficient,
                        height: 40 * coefficient,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: SatorioColor.magic_mint,
                              width: 3 * coefficient),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            'images/tmp_shuriken.png',
                            height: 24 * coefficient,
                            width: 24 * coefficient,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.profileRx.value?.displayedName ?? '',
                          style: textTheme.headline6!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 18.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.showInvite();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(24, 24),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          primary: SatorioColor.brand,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'txt_invite_friends'.tr.toUpperCase(),
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 12.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  SatorIcons.exit,
                  size: 24,
                ),
                onPressed: () {
                  controller.logout();
                },
              )
            ],
          ),
        ),

      ],
    );
  }
}
