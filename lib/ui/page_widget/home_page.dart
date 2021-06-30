import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/avatar_list.dart';

class HomePage extends GetView<HomeController> {
  final int avatarIndex = Random().nextInt(avatars.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SatorioColor.darkAccent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: SatorioColor.darkAccent,
              height: 190,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 76),
                      child: InkWell(
                        onTap: () {
                          controller.toLogoutDialog();
                        },
                        child: Obx(
                          () => Text(
                            controller.profileRx.value?.displayedName ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 67, right: 20),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 5,
                          color: Colors.white.withOpacity(0.12),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: SatorioColor.casablanca,
                          ),
                          child: Center(
                            child: ClipOval(
                              child: SvgPicture.asset(
                                avatars[avatarIndex],
                                width: 50,
                                height: 50,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 158),
              height: 115,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                color: SatorioColor.interactive,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 21, left: 20),
                      child: Text(
                        'txt_wallet'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 16),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.walletRx.value.length > 0
                                  ? controller.walletRx.value[0].displayedValue
                                  : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              controller.walletRx.value.length > 1
                                  ? controller.walletRx.value[1].displayedValue
                                  : '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 231),
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
    );
  }

  Widget _contentWithCategories() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
          child: Text(
            'Highest Rewarding',
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168,
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
          child: Text(
            'Most Socializing',
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168,
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
          child: Text(
            'Newest Added',
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168,
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
      ],
    );
  }

  @Deprecated('changes 23.06')
  Widget _contentWithBadgesChallengesNfts() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 20),
          child: Text(
            'txt_badges'.tr,
            style: TextStyle(
              color: SatorioColor.textBlack,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 100,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 10,
            itemBuilder: (context, index) {
              String assetName;
              switch (index) {
                case 0:
                  assetName = 'badge_1';
                  break;
                case 1:
                  assetName = 'badge_2';
                  break;
                case 2:
                  assetName = 'badge_3';
                  break;
                case 3:
                  assetName = 'badge_4';
                  break;
                case 4:
                  assetName = 'badge_5';
                  break;
                case 5:
                  assetName = 'badge_6';
                  break;
                default:
                  assetName = 'badge_closed';
                  break;
              }
              return _badgeItem(assetName, index);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 10),
          child: InkWell(
            onTap: () {
              // controller.toShows();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'txt_challenges'.tr,
                    style: TextStyle(
                      color: SatorioColor.textBlack,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168,
          child: Obx(
            () => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 16,
              ),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.showsRx.value.length,
              itemBuilder: (context, index) {
                Show show = controller.showsRx.value[index];
                return _showItem(show);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'txt_nfts'.tr,
                  style: TextStyle(
                    color: SatorioColor.textBlack,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 32,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 168,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 5,
            itemBuilder: (context, index) {
              String img;
              String name;
              switch (index) {
                case 0:
                  img = 'nfts_1';
                  name = "Game of Thrones";
                  break;
                case 1:
                  img = 'nfts_4';
                  name = "Sopranos";
                  break;
                case 2:
                  img = 'nfts_5';
                  name = "Simpsons";
                  break;
                case 3:
                  img = 'nfts_2';
                  name = "Breaking Bad";
                  break;
                case 4:
                  img = 'nfts_3';
                  name = "Batman and Robin";
                  break;
                default:
                  img = 'nfts_5';
                  name = "Simpsons";
                  break;
              }
              return _nftsItem(img, name);
            },
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget _badgeItem(String assetName, int index) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: SatorioColor.alice_blue,
      ),
      child: Center(
        child: Image.asset(
          "images/new/$assetName.png",
          height: 60,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _showItem(Show show) {
    final width = Get.width - 20 - 32;
    final height = 168.0;
    return InkWell(
      onTap: () {
        controller.toShowDetail(show);
      },
      onLongPress: () {
        controller.toShowChallenges(show);
      },
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                width: width,
                height: height,
                fit: BoxFit.cover,
                image: NetworkImage(show.cover),
                errorBuilder: (context, error, stackTrace) => Container(
                  color: SatorioColor.grey,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: SatorioColor.lavender_rose,
                      ),
                      child: Text(
                        'Rank #1',
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
      ),
    );
  }

  Widget _nftsItem(String assetName, String name) {
    double width = Get.width - 20 - 32;
    double height = 168.0;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "images/new/$assetName.png",
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 7,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: SatorioColor.lavender_rose,
                    ),
                    child: Text(
                      'Rank #1',
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
