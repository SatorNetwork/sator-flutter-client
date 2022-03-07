import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_top_up_controller.dart';
import 'package:satorio/domain/entities/buy_sao.dart';
import 'package:satorio/domain/entities/exchange_option.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';

import '../theme/text_theme.dart';

class WalletTopUpPage extends GetView<WalletTopUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_top_up'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: SatorioColor.darkAccent,
              size: 32,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Container(
            width: Get.width,
            height: Get.height - kToolbarHeight,
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
                      Text('txt_top_up_options'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: SatorioColor.darkAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 20 * coefficient,
                      ),
                      _toggleButton(),
                      SizedBox(
                        height: 30 * coefficient,
                      ),
                      Obx(
                        () => Text(
                            !controller.isExchangeRx.value
                                ? 'txt_top_up_buy'.tr
                                : 'txt_top_up_exchange_options'.tr,
                            style: textTheme.bodyText1!.copyWith(
                              color: SatorioColor.darkAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SizedBox(
                        height: 20 * coefficient,
                      ),
                      Obx(
                        () => Container(
                          child: !controller.isExchangeRx.value
                              ? _buySaoItems()
                              : _exchangeItems(),
                        ),
                      ),
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

  Widget _toggleButton() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: InkWell(
              onTap: () {
                controller.toggle(false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.isExchangeRx.value
                      ? SatorioColor.alice_blue
                      : SatorioColor.interactive,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 75 * coefficient,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/sator_logo.svg',
                        width: 20,
                        height: 20,
                        color: controller.isExchangeRx.value
                            ? SatorioColor.darkAccent
                            : Colors.white,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text('txt_top_up_buy_sao'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: controller.isExchangeRx.value
                                ? SatorioColor.darkAccent
                                : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 24 * coefficient,
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                controller.toggle(true);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.isExchangeRx.value
                      ? SatorioColor.interactive
                      : SatorioColor.alice_blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 75 * coefficient,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/exchange.svg',
                        width: 20,
                        height: 20,
                        color: controller.isExchangeRx.value
                            ? Colors.white
                            : SatorioColor.darkAccent,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text('txt_top_up_exchange'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: controller.isExchangeRx.value
                                ? Colors.white
                                : SatorioColor.darkAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _exchangeItem(ExchangeOption option) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 76,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: SatorioColor.alice_blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('${option.market}',
                style: textTheme.bodyText1!.copyWith(
                  color: SatorioColor.darkAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            Image.asset(_marketImage(option.market))
          ],
        ),
      ),
    );
  }

  Widget _buySaoItem(BuySao buySao) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 76,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: SatorioColor.alice_blue),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    SatorioColor.royal_blue_2,
                    SatorioColor.brand,
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              width: 36,
              height: 36,
              child: Center(
                child: SvgPicture.asset(
                  'images/sator_logo.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                    text: buySao.saoAmount.toStringAsFixed(0),
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: ' SAO',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
            Expanded(
                child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                        text: '${buySao.currency}',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '${buySao.price}',
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.textBlack,
                              fontSize: 15 * coefficient,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ])))
          ],
        ),
      ),
    );
  }

  String _marketImage(String market) {
    switch (market.toLowerCase()) {
      case 'coinbase':
        return 'images/coinbase.png';
      case 'binance':
        return 'images/binance.png';
      case 'uniswap':
        return 'images/uniswap.png';
      default:
        return 'images/uniswap.png';
    }
  }

  Widget _buySaoItems() {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: dummyBuySao.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
              height: 14,
            ),
        itemBuilder: (context, index) {
          BuySao buySao = dummyBuySao[index];
          return _buySaoItem(buySao);
        });
  }

  Widget _exchangeItems() {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: dummyExchangeOptions.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
              height: 14,
            ),
        itemBuilder: (context, index) {
          ExchangeOption exchangeOption = dummyExchangeOptions[index];
          return _exchangeItem(exchangeOption);
        });
  }

  final List<BuySao> dummyBuySao = [
    BuySao(1000.00, 99.99, '\$'),
    BuySao(10000.00, 999.99, '\$'),
    BuySao(100000.00, 9999.99, '\$'),
  ];

  final List<ExchangeOption> dummyExchangeOptions = [
    ExchangeOption('txt_coinbase'.tr),
    ExchangeOption('txt_binance'.tr),
    ExchangeOption('txt_uniswap'.tr),
  ];
}
