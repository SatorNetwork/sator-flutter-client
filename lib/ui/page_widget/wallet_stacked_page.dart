import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_stacked_controller.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/wallet_detail_container.dart';

class WalletStackedPage extends GetView<WalletStackedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: SatorioColor.darkAccent,
            ),
            onPressed: () {
              controller.back();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: Get.width,
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 28, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WalletDetailContainer(
                        _mockWalletDetail(),
                        height: 200,
                      ),
                      SizedBox(
                        height: 32 * coefficient,
                      ),
                      Text(
                        'txt_staking'.tr,
                        style: textTheme.headline3!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 28 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16 * coefficient,
                      ),
                      _stackingCard(),
                      SizedBox(
                        height: 32 * coefficient,
                      ),
                      Text(
                        'txt_loyalty_levels'.tr,
                        style: textTheme.headline3!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 28 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16 * coefficient,
                      ),
                      _loyaltyLevelCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stackingCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'txt_auto_sator'.tr,
                      style: textTheme.headline5!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 20 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'txt_automatic_restaking'.tr,
                      style: textTheme.bodyText1!.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 48 * coefficient,
                height: 48 * coefficient,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SatorioColor.mauve,
                ),
                child: Center(
                  child: Icon(
                    SatorIcons.logo,
                    size: 40 * coefficient,
                    color: SatorioColor.brand,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            children: [
              Text(
                'txt_apy'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  '138.7%',
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          Row(
            children: [
              Text(
                'txt_total_staked'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  '25,438,101.353',
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          ElevatedGradientButton(
            text: 'txt_stake'.tr,
          ),
        ],
      ),
    );
  }

  Widget _loyaltyLevelCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(width: 2, color: SatorioColor.interactive),
          bottom: BorderSide(width: 2, color: SatorioColor.interactive),
          left: BorderSide(width: 2, color: SatorioColor.interactive),
          right: BorderSide(width: 2, color: SatorioColor.interactive),
        ),
        color: SatorioColor.alice_blue,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gold',
                            style: textTheme.headline5!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 20 * coefficient,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '5-10%',
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.manatee,
                              fontSize: 12 * coefficient,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 48 * coefficient,
                      height: 48 * coefficient,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border(
                          top: BorderSide(
                              width: 2, color: SatorioColor.royal_blue_2),
                          bottom: BorderSide(
                              width: 2, color: SatorioColor.royal_blue_2),
                          left: BorderSide(
                              width: 2, color: SatorioColor.royal_blue_2),
                          right: BorderSide(
                              width: 2, color: SatorioColor.royal_blue_2),
                        ),
                        color: SatorioColor.interactive,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.star_rounded,
                          size: 32 * coefficient,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20 * coefficient,
                ),
                Row(
                  children: [
                    Text(
                      'txt_data'.tr,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '138.7% ',
                        textAlign: TextAlign.end,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8 * coefficient,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'txt_dividends'.tr,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 24 * coefficient,
                      height: 24 * coefficient,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SatorioColor.lavender_blue,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: 18 * coefficient,
                          color: SatorioColor.interactive,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8 * coefficient,
                ),
                Row(
                  children: [
                    Text(
                      'txt_number'.tr,
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '138,256.75',
                        textAlign: TextAlign.end,
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18)),
              color: SatorioColor.interactive,
            ),
            child: Center(
              child: Text(
                'txt_current'.tr,
                textAlign: TextAlign.end,
                style: textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 17 * coefficient,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  WalletDetail _mockWalletDetail() {
    return WalletDetail(
      'id',
      'solanaAccountAddress',
      [
        AmountCurrency(852.2, 'SAO'),
        AmountCurrency(2642.59, 'USD'),
        AmountCurrency(2525.59, 'Rewarded'),
      ],
      [],
    );
  }
}
