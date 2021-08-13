import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/title_button.dart';
import 'package:satorio/util/avatar_list.dart';

class HomePage extends GetView<HomeController> {
  final int avatarIndex = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        color: SatorioColor.brand,
        onRefresh: () async {
          controller.refreshHomePage();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: SatorioColor.darkAccent,
                // height: 190,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'images/bg/gradient.svg',
                      height: Get.height,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 76, right: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            controller.toLogoutDialog();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        color: SatorioColor.casablanca,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          avatars[avatarIndex],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller
                                              .profileRx.value?.displayedName ??
                                          '',
                                      style: textTheme.headline1!.copyWith(
                                          color: SatorioColor.darkAccent,
                                          fontSize: 14.0 * coefficient,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.walletRx.value.length > 0
                                          ? controller
                                              .walletRx.value[0].displayedValue
                                          : '',
                                      style: textTheme.bodyText1!.copyWith(
                                        color: SatorioColor.darkAccent,
                                        fontSize: 18.0 * coefficient,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: Colors.white,
                ),
                child: _contentWithCategories(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentWithCategories() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: TitleWithButton(textCode: 'Highest Rewarding', onTap: () {}),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168 * coefficient,
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.showsHighestRewardingRx.value.length,
              itemBuilder: (context, index) {
                Show show = controller.showsHighestRewardingRx.value[index];
                return _showItem(show);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: TitleWithButton(textCode: 'Most Socializing', onTap: () {}),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168 * coefficient,
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.showsMostSocializingRx.value.length,
              itemBuilder: (context, index) {
                Show show = controller.showsMostSocializingRx.value[index];
                return _showItem(show);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: TitleWithButton(textCode: 'Newest Added', onTap: () {}),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168 * coefficient,
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.showsNewestAddedRx.value.length,
              itemBuilder: (context, index) {
                Show show = controller.showsNewestAddedRx.value[index];
                return _showItem(show);
              },
            ),
          ),
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget _showItem(Show show) {
    final width = Get.width - 20 - 32;
    final height = 168.0 * coefficient;
    return InkWell(
      onTap: () {
        controller.toShowDetail(show);
      },
      onLongPress: () {
        controller.toShowChallenges(show);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Image(
                width: width,
                height: height,
                fit: BoxFit.cover,
                image: NetworkImage(show.cover),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: SatorioColor.grey,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          show.title,
                          style: textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontSize: 20.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: SatorioColor.lavender_rose,
                        ),
                        child: Text(
                          'NFT',
                          style: textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 12.0 * coefficient,
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
        ),
      ),
    );
  }
}
