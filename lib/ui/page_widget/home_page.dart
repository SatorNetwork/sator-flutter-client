import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/home_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class HomePage extends GetView<HomeController> {
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
                          Get.defaultDialog(
                            title: 'txt_alert'.tr,
                            titleStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                            content: Text(
                              'txt_logout_message'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                controller.logout();
                              },
                              child: Text(
                                'txt_yes'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Obx(
                          () => Text(
                            controller.profileRx.value == null
                                ? ''
                                : controller.profileRx.value.displayedName,
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
                            child: Text(
                              '#1',
                              style: TextStyle(
                                color: SatorioColor.raw_umber,
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
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
                        () => controller.walletBalanceRx.value == null
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.walletBalanceRx.value.sao
                                        .displayedValue,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    controller.walletBalanceRx.value.usd
                                        .displayedValue,
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
              child: Column(
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
                        switch (index % 3) {
                          case 0:
                            assetName = 'images/badge1.png';
                            break;
                          case 1:
                            assetName = 'images/badge2.png';
                            break;
                          case 2:
                            assetName = 'images/badge3.png';
                            break;
                        }
                        return _badgeItem(assetName);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 20, right: 10),
                    child: InkWell(
                      onTap: () {
                        controller.toShows();
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
                    padding:
                        const EdgeInsets.only(top: 24, left: 20, right: 10),
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
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return _nftsItem();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _badgeItem(String assetName) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: SatorioColor.alice_blue,
      ),
      child: Center(
        child: Image.asset(
          assetName,
          height: 40,
          fit: BoxFit.fitHeight,
        ),
        // child: SvgPicture.asset(
        //   assetName,
        //   width: 40,
        //   height: 40,
        // ),
      ),
    );
  }

  Widget _showItem(Show show) {
    final width = Get.width - 20 - 32;
    final height = 168.0;
    return InkWell(
      onTap: () => controller.toShowChallenges(show),
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
                image: NetworkImage(show.cover),
                fit: BoxFit.cover,
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
                        show.title,
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

  Widget _nftsItem() {
    double width = Get.width - 20 - 32;
    return Container(
      width: width,
      height: 168,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image(
              image: NetworkImage('https://picsum.photos/${width.round()}/168'),
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
