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
        title: Text('txt_top_up'.tr,
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
                      Text('txt_top_up_options'.tr, style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                      SizedBox(height: 20 * coefficient,),
                      _toggleButton(),
                      SizedBox(height: 30 * coefficient,),
                      Text('txt_top_up_buy'.tr, style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.darkAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                      SizedBox(height: 20 * coefficient,),
                      Obx(
                        () =>
                            Container(
                          child: controller.isExchangeRx.value ? _buySaoItems() : _buySaoItems(),
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
                  color: controller.isExchangeRx.value ? SatorioColor.alice_blue : SatorioColor.interactive,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 75 * coefficient,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/sator_logo.svg', width: 20, height: 20, color: controller.isExchangeRx.value ?  SatorioColor.darkAccent : Colors.white,),
                      SizedBox(height: 4,),
                      Text('txt_top_up_buy_sao'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: controller.isExchangeRx.value ?  SatorioColor.darkAccent : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 24 * coefficient,),
          Flexible(
            child: InkWell(
              onTap: () {
                controller.toggle(true);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.isExchangeRx.value ? SatorioColor.interactive : SatorioColor.alice_blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 75 * coefficient,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/exchange.svg', width: 20, height: 20, color: controller.isExchangeRx.value ?  Colors.white : SatorioColor.darkAccent,),
                      SizedBox(height: 4,),
                      Text('txt_top_up_exchange'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: controller.isExchangeRx.value ?  Colors.white : SatorioColor.darkAccent,
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

  Widget _buySaoItem(BuySao buySao) {
    return Container(
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 24,
              height: 24,
              color: SatorioColor.mauve,
              child: Center(
                child: SvgPicture.asset(
                  'images/sator_logo.svg',
                  width: 12,
                  height: 12,
                  color: SatorioColor.brand,
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          RichText(
              text: TextSpan(
                  text: buySao.saoAmount.toString(),
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'SAO',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ])),
          Expanded(child: Container()),
          Flexible(child: RichText(
            text: TextSpan(
              text: buySao.price.toString(),
              style: textTheme.bodyText2!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 15 * coefficient,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: buySao.currency,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          ])))
        ],
      ),
    );
  }

  Widget _exchangeOptionItem(ExchangeOption exchangeOption) {
    return Container(
      child: Row(
        children: [
          Text(exchangeOption.market),
          SvgPicture.asset('')
        ],
      ),
    );
  }

  Widget _buySaoItems() {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        itemCount: dummyBuySao.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          BuySao buySao = dummyBuySao[index];
          return _buySaoItem(buySao);
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
