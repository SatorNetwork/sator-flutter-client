import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/controller/wallet_controller.dart';
import 'package:satorio/domain/entities/transaction.dart';
import 'package:satorio/domain/entities/wallet_action.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/wallet_detail_container.dart';
import 'package:satorio/util/extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPage extends GetView<WalletController> {
  static const double _threshHold = 0.0;
  static const double _separatorSize = 6.0;

  late final double _viewportFraction =
      (Get.width - 2 * (8 + _separatorSize)) / Get.width;

  WalletPage() {
    controller.setupPageController(_viewportFraction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
          color: SatorioColor.brand,
          onRefresh: () async {
            controller.refreshAllWallets();
          },
          child: _walletContent()),
      bottomSheet: _transactionContent(),
    );
  }

  Widget _walletContent() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 64),
                child: Center(
                  child: Text(
                    'txt_wallet'.tr,
                    style: textTheme.headline2!.copyWith(
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
                height: 270,
                child: Obx(
                  () => PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.walletDetailsRx.value.length,
                    itemBuilder: (context, index) {
                      WalletDetail walletDetail =
                          controller.walletDetailsRx.value[index];
                      return Column(
                        children: [
                          WalletDetailContainer(
                            walletDetail,
                            height: 200,
                            margin: EdgeInsets.symmetric(
                              horizontal: _separatorSize / _viewportFraction,
                            ),
                          ),
                          SizedBox(height: 20,),
                          _walletButtons(walletDetail.type, walletDetail),
                        ],
                      );
                      // return _walletItem(walletDetail);
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
                height: 24 * coefficient,
              ),
              Container(
                height: 90,
                child: Obx(
                  () => controller.isClaimLoadRx.value
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: SatorioColor.brand,
                        ))
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 50,
                          ),
                          itemCount: controller.walletDetailsRx.value.length > 0
                              ? controller.walletDetailsRx
                                  .value[controller.pageRx.value].actions.length
                              : 0,
                          itemBuilder: (context, index) {
                            WalletDetail walletDetail = controller
                                .walletDetailsRx.value[controller.pageRx.value];
                            WalletAction walletAction =
                                walletDetail.actions[index];
                            return _walletActionItem(
                                walletDetail, walletAction);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walletButtons(String walletType, WalletDetail walletDetail) {
    switch (walletType) {
      case 'sao':
        return _buttonItem('txt_get_sao'.tr, () => controller.toTopUp());
      default:
        return _buttonItem('txt_to_challenges'.tr, () => controller.toChallenges());
    }
  }

  Widget _buttonItem(String label, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BorderedButton(
        text: label,
        borderRadius: 60,
        onPressed: onPressed,
      ),
    );
  }

  Widget _transactionContent() {
    final double minSize =
        (Get.height - (520 * coefficient) - kBottomNavigationBarHeight) / Get.height;
    final double maxSize =
        (Get.height - Get.mediaQuery.padding.top - 1) / Get.height;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) =>
          NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - _threshHold)
            controller.loadMoreTransactions();
          return true;
        },
        child: SingleChildScrollView(
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
                      color: Colors.black.withOpacity(0.1),
                      height: 1,
                    ),
                    itemCount: controller.walletDetailsRx.value.length > 0
                        ? (controller
                                .walletTransactionsRx
                                .value[controller.walletDetailsRx
                                    .value[controller.pageRx.value].id]
                                ?.length ??
                            0)
                        : 0,
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
      ),
    );
  }

  Widget _walletActionItem(
    WalletDetail walletDetail,
    WalletAction walletAction,
  ) {
    return InkWell(
      onTap: () {
        switch (walletAction.type) {
          case Type.send_tokens:
            controller.toSend(walletDetail);
            break;
          case Type.receive_tokens:
            controller.toReceive(walletDetail);
            break;
          case Type.claim_rewards:
            controller.toClaimRewards(walletAction.url);
            break;
          case Type.stake_tokens:
            controller.toStake(walletDetail);
            break;
          default:
            break;
        }
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
      case Type.stake_tokens:
        return Icons.arrow_forward_rounded;
      default:
        return Icons.arrow_forward_rounded;
    }
  }
}
