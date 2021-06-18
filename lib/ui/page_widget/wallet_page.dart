import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPage extends GetView<WalletController> {
  static const double _separatorSize = 6.0;
  late final double _viewportFraction =
      (Get.width - 2 * (8 + _separatorSize)) / Get.width;

  late final PageController _pageController =
      PageController(viewportFraction: _viewportFraction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: _walletContent(),
      bottomSheet: _transactionContent(),
    );
  }

  Widget _walletContent() {
    return Stack(
      children: [
        SvgPicture.asset(
          'images/bg/gradient.svg',
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 64),
              child: Center(
                child: Text(
                  'txt_wallet'.tr,
                  style: TextStyle(
                    color: SatorioColor.darkAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _walletItem();
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: SatorioColor.darkAccent,
                dotColor: SatorioColor.darkAccent.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    controller.send();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: SatorioColor.interactive,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'txt_send'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                InkWell(
                  onTap: () {
                    controller.receive();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: SatorioColor.interactive,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'txt_receive'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _transactionContent() {
    final double minSize =
        (Get.height - 453 - kBottomNavigationBarHeight) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 28,
                  bottom: 12,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  'txt_transactions'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
                  itemCount: controller.transactionsRx.value.length,
                  itemBuilder: (context, index) {
                    double value = controller.transactionsRx.value[index];
                    return _transactionItem(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletItem() {
    final height = 200.0;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: _separatorSize / _viewportFraction),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: SatorioColor.darkAccent,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'images/sator_wallet.png',
                height: height,
                fit: BoxFit.cover,
                // color: Colors.white.withOpacity(0.5),
                // colorBlendMode: BlendMode.luminosity,
              ),
              // child: ColorFiltered(
              //   colorFilter: ColorFilter.mode(
              //     Colors.white,
              //     BlendMode.luminosity,
              //   ),
              //   // colorFilter: ColorFilter.matrix(<double>[
              //   //   0.2126, 0.7152, 0.0722, 0, 0,
              //   //   0.2126, 0.7152, 0.0722, 0, 0,
              //   //   0.2126, 0.7152, 0.0722, 0, 0,
              //   //   0, 0, 0, 1, 0,
              //   // ]),
              //   child: Image.asset(
              //     'images/sator_wallet.png',
              //     height: height,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 22, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '852.2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        TextSpan(
                          text: 'SAO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '2642.59',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        backgroundColor: Colors.transparent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        TextSpan(
                          text: 'USD',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     margin: const EdgeInsets.only(bottom: 30, left: 24),
          //     padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(35),
          //       color: Colors.white.withOpacity(0.25),
          //     ),
          //     child: Text(
          //       '2,525.59 Rewards',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 12.0,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _transactionItem(double value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: 63,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'txt_transaction'.tr,
                style: TextStyle(
                  color: SatorioColor.textBlack,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  value >= 0 ? '+$value' : '$value',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color:
                        value >= 0 ? SatorioColor.success : SatorioColor.error,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                '3P4Q3E---------4QWSSA'.ellipsize(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  'April 28, 2021',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
