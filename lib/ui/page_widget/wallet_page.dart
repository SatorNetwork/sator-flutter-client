import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPage extends GetView<WalletController> {
  static const double _separatorSize = 6.0;
  late double _viewportFraction =
      (Get.width - 2 * (8 + _separatorSize)) / Get.width;
  late PageController _pageController =
      PageController(viewportFraction: _viewportFraction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
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
                  Column(
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
                  SizedBox(
                    width: 50,
                  ),
                  Column(
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
                ],
              ),
            ],
          ),
        ],
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, left: 24),
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white.withOpacity(0.25),
              ),
              child: Text(
                '2,525.59 Rewards',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
