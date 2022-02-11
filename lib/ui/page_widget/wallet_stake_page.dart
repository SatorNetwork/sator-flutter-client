import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_stake_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/wallet_detail_container.dart';

class WalletStakePage extends GetView<WalletStakeController> {
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
                      Obx(
                        () => WalletDetailContainer(
                          controller.walletDetailRx.value,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 32 * coefficient,
                      ),
                      Text(
                        'txt_lock_rewards'.tr,
                        style: textTheme.headline3!.copyWith(
                          color: SatorioColor.textBlack,
                          fontSize: 28 * coefficient,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16 * coefficient,
                      ),
                      Obx(
                        () => controller.tmpState.value
                            ? _stackingCard2()
                            : _stackingCard1(),
                      ),
                      SizedBox(
                        height: 32 * coefficient,
                      ),
                      // Text(
                      //   'txt_loyalty_levels'.tr,
                      //   style: textTheme.headline3!.copyWith(
                      //     color: SatorioColor.textBlack,
                      //     fontSize: 28 * coefficient,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 16 * coefficient,
                      // ),
                      // _loyaltyLevelCard(),
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

  Widget _stackingCard1() {
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
                      'txt_multiply_rewards'.tr,
                      style: textTheme.headline5!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 20 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text: 'txt_total_locked'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${controller.walletStakingRx.value?.totalLocked ?? ''}',
                              style: textTheme.bodyText1!.copyWith(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 12 * coefficient,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
                  child: SvgPicture.asset(
                    'images/sator_logo.svg',
                    width: 24 * coefficient,
                    height: 24 * coefficient,
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
                'txt_locked_by'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    '${controller.walletStakingRx.value?.lockedByYou ?? ''}',
                    textAlign: TextAlign.end,
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
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
                'txt_multiplier'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                  child: Obx(
                () => Text(
                  '${controller.walletStakingRx.value?.currentMultiplier ?? ''}%',
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          ElevatedGradientButton(
            text: 'txt_add'.tr,
            onPressed: () {
              controller.toLockRewardsBottomSheet();
            },
          ),
        ],
      ),
    );
  }

  Widget _stackingCard2() {
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
                      'txt_multiply_rewards'.tr,
                      style: textTheme.headline5!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 20 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text: 'txt_total_locked'.tr,
                          style: textTheme.bodyText1!.copyWith(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12 * coefficient,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' ${controller.walletStakingRx.value?.totalLocked}',
                              style: textTheme.bodyText1!.copyWith(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 12 * coefficient,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
                  child: SvgPicture.asset(
                    'images/sator_logo.svg',
                    width: 24 * coefficient,
                    height: 24 * coefficient,
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
                'txt_locked_by'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    '${controller.walletStakingRx.value?.lockedByYou ?? ''}',
                    textAlign: TextAlign.end,
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w600,
                    ),
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
                'txt_multiplier'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                  fontSize: 15 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                  child: Obx(
                () => Text(
                  '${controller.walletStakingRx.value?.currentMultiplier.toString()}%',
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                    fontSize: 15 * coefficient,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: BorderedButton(
                  text: 'txt_unlock'.tr,
                  onPressed: () {
                    controller.toUnLockRewardsBottomSheet();
                  },
                ),
              ),
              SizedBox(
                width: 12 * coefficient,
              ),
              Expanded(
                child: ElevatedGradientButton(
                  text: 'txt_add'.tr,
                  onPressed: () {
                    controller.toLockRewardsBottomSheet();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _loyaltyLevelCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(
  //         width: 2,
  //         color: SatorioColor.interactive,
  //       ),
  //       color: SatorioColor.alice_blue,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           padding:
  //               const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Obx(
  //                           () => Text(
  //                             controller.walletStakeRx.value?.walletLoyalty
  //                                     ?.levelTitle ??
  //                                 '',
  //                             style: textTheme.headline5!.copyWith(
  //                               color: SatorioColor.textBlack,
  //                               fontSize: 20 * coefficient,
  //                               fontWeight: FontWeight.w700,
  //                             ),
  //                           ),
  //                         ),
  //                         Obx(
  //                           () => Text(
  //                             controller.walletStakeRx.value?.walletLoyalty
  //                                     ?.levelSubtitle ??
  //                                 '',
  //                             style: textTheme.bodyText1!.copyWith(
  //                               color: SatorioColor.manatee,
  //                               fontSize: 12 * coefficient,
  //                               fontWeight: FontWeight.w400,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     width: 48 * coefficient,
  //                     height: 48 * coefficient,
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       border: Border.all(
  //                         color: SatorioColor.royal_blue_2,
  //                         width: 2,
  //                       ),
  //                       color: SatorioColor.interactive,
  //                     ),
  //                     child: Center(
  //                       child: Icon(
  //                         Icons.star_rounded,
  //                         size: 32 * coefficient,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20 * coefficient,
  //               ),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'txt_data'.tr,
  //                     style: textTheme.bodyText2!.copyWith(
  //                       color: SatorioColor.textBlack,
  //                       fontSize: 15 * coefficient,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       '138.7% ',
  //                       textAlign: TextAlign.end,
  //                       style: textTheme.bodyText2!.copyWith(
  //                         color: SatorioColor.textBlack,
  //                         fontSize: 15 * coefficient,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 8 * coefficient,
  //               ),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text(
  //                       'txt_dividends'.tr,
  //                       style: textTheme.bodyText2!.copyWith(
  //                         color: SatorioColor.textBlack,
  //                         fontSize: 15 * coefficient,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     width: 24 * coefficient,
  //                     height: 24 * coefficient,
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: SatorioColor.lavender_blue,
  //                     ),
  //                     child: Center(
  //                       child: Icon(
  //                         Icons.check_rounded,
  //                         size: 18 * coefficient,
  //                         color: SatorioColor.interactive,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 8 * coefficient,
  //               ),
  //               Row(
  //                 children: [
  //                   Text(
  //                     'txt_number'.tr,
  //                     style: textTheme.bodyText2!.copyWith(
  //                       color: SatorioColor.textBlack,
  //                       fontSize: 15 * coefficient,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       '138,256.75',
  //                       textAlign: TextAlign.end,
  //                       style: textTheme.bodyText2!.copyWith(
  //                         color: SatorioColor.textBlack,
  //                         fontSize: 15 * coefficient,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           padding: const EdgeInsets.symmetric(vertical: 10),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 bottomRight: Radius.circular(18),
  //                 bottomLeft: Radius.circular(18)),
  //             color: SatorioColor.interactive,
  //           ),
  //           child: Center(
  //             child: Text(
  //               'txt_current'.tr,
  //               textAlign: TextAlign.end,
  //               style: textTheme.bodyText1!.copyWith(
  //                 color: Colors.white,
  //                 fontSize: 17 * coefficient,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
