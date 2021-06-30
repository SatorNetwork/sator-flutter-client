import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPage extends GetView<WalletController> {
  static const double _separatorSize = 6.0;
  late final double _viewportFraction =
      (Get.width - 2 * (8 + _separatorSize)) / Get.width;

  WalletPage() {
    controller.pageController =
        PageController(viewportFraction: _viewportFraction);
  }

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
              child: Obx(
                () => PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.walletDetailsRx.value.length,
                  itemBuilder: (context, index) {
                    WalletDetail walletDetail =
                        controller.walletDetailsRx.value[index];
                    return _walletItem(walletDetail);
                  },
                  onPageChanged: (value) {
                    controller.changePage(value);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(
              () => SmoothPageIndicator(
                controller: controller.pageController,
                count: max(controller.walletDetailsRx.value.length, 1),
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: SatorioColor.darkAccent,
                  dotColor: SatorioColor.darkAccent.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 90,
              child: Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 50,
                  ),
                  itemCount: controller.walletDetailsRx
                      .value[controller.pageRx.value].actions.length,
                  itemBuilder: (context, index) {
                    WalletAction waleltAction = controller.walletDetailsRx
                        .value[controller.pageRx.value].actions[index];
                    return _walletActionItem(waleltAction);
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
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
                  itemCount: controller
                          .walletTransactionsRx
                          .value[controller.walletDetailsRx
                              .value[controller.pageRx.value].id]
                          ?.length ??
                      0,
                  itemBuilder: (context, index) {
                    Transaction transaction =
                        controller.walletTransactionsRx.value[controller
                            .walletDetailsRx
                            .value[controller.pageRx.value]
                            .id]![index];
                    return _transactionItem(transaction);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletItem(WalletDetail walletDetail) {
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
              ),
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
                      text: walletDetail.balance.length > 0
                          ? walletDetail.balance[0].amount.toStringAsFixed(2)
                          : '',
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
                          text: walletDetail.balance.length > 0
                              ? walletDetail.balance[0].currency
                              : '',
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
                      text: walletDetail.balance.length > 1
                          ? walletDetail.balance[1].amount.toStringAsFixed(2)
                          : '',
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
                          text: walletDetail.balance.length > 1
                              ? walletDetail.balance[1].currency
                              : '',
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
        ],
      ),
    );
  }

  Widget _walletActionItem(WalletAction walletAction) {
    return InkWell(
      onTap: () {},
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
                _walletActionIcon(walletAction.type),
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            walletAction.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(Transaction transaction) {
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
                  transaction.amount >= 0
                      ? '+${transaction.amount}'
                      : '${transaction.amount}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: transaction.amount >= 0
                        ? SatorioColor.success
                        : SatorioColor.error,
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
                transaction.txHash.ellipsize(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  transaction.createdAt == null
                      ? ''
                      : DateFormat('MMM dd, yyyy')
                          .format(transaction.createdAt!),
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

  IconData _walletActionIcon(String walletActionType) {
    switch (walletActionType) {
      case Type.send_tokens:
        return Icons.arrow_upward_rounded;
      case Type.receive_tokens:
        return Icons.arrow_downward_rounded;
      case Type.claim_rewards:
        return Icons.arrow_downward_rounded;
      default:
        return Icons.error_outline_rounded;
    }
  }
}
