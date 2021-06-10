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
                          controller.toLogoutDialog();
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
                        switch (index) {
                          case 0:
                            assetName = 'images/new/badge1.png';
                            break;
                          case 1:
                            assetName = 'images/new/badge2.png';
                            break;
                          default:
                            assetName = 'images/new/badge3.png';
                            break;
                        }
                        return _badgeItem(assetName, index);
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        String img;
                        switch (index) {
                          case 0:
                            img =
                                'https://fanart.tv/fanart/tv/277165/tvthumb/silicon-valley-5915a9878d077.jpg';
                            break;
                          case 1:
                            img =
                                'https://slpecho.com/wp-content/uploads/2019/10/friends-art-for-web-900x640.jpg';
                            break;
                          default:
                            img =
                                'https://btcmanager.com/wp-content/uploads/2018/05/Someone-Made-That-Silicon-Valley-Alert-That-Plays-Death-Metal-Whenever-Bitcoin-Price-Moves.jpg';
                            break;
                        }
                        return _nftsItem(img);
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

  Widget _badgeItem(String assetName, int index) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: SatorioColor.alice_blue,
      ),
      child: Center(
        child: ColorFiltered(
          colorFilter: index < 2
              ? ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.multiply,
                )
              : ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
          child: Image.asset(
            assetName,
            height: 60,
            fit: BoxFit.fitHeight,
          ),
        ),
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

  Widget _nftsItem(String imgURL) {
    double width = Get.width - 20 - 32;
    double height = 168.0;
    return Container(
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
              image: NetworkImage(
                imgURL,
              ),
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
                      'Hold on for dear life',
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
