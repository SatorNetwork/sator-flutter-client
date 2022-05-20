import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class NftItemPage extends GetView<NftItemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 63 * coefficient),
                        width: Get.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: SatorioColor.acadia,
                              offset: Offset(0, 4),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Opacity(
                            opacity: 0.55,
                            child: Obx(
                              () => Image.network(
                                controller.nftItemRx.value.nftPreview.isEmpty
                                    ? controller.nftItemRx.value.nftLink
                                    : controller.nftItemRx.value.nftPreview,
                                fit: BoxFit.cover,
                                color: SatorioColor.acadia,
                                colorBlendMode: BlendMode.plus,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 63 * coefficient,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    top: Get.mediaQuery.padding.top + kToolbarHeight,
                    right: 20,
                  ),
                  width: Get.width - 2 * 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Obx(
                      () => Image.network(
                        controller.nftItemRx.value.nftPreview.isEmpty
                            ? controller.nftItemRx.value.nftLink
                            : controller.nftItemRx.value.nftPreview,
                        fit: BoxFit.contain,
                        color: SatorioColor.acadia,
                        colorBlendMode: BlendMode.plus,
                      ),
                    ),
                  ),
                ),
                //TODO: uncomment when functionality will be added
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Obx(
                //     () => controller.nftItemRx.value.isVideoNft()
                //         ? Container(
                //             margin: EdgeInsets.only(
                //               right: 20 + 10 * coefficient,
                //               bottom: 10 * coefficient,
                //             ),
                //             child: FloatingActionButton(
                //               onPressed: () {
                //                 controller.toNetworkVideo();
                //               },
                //               backgroundColor: SatorioColor.darkAccent,
                //               splashColor: SatorioColor.interactive,
                //               child: Icon(
                //                 Icons.play_arrow_rounded,
                //                 size: 32,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           )
                //         : SizedBox(
                //             height: 0,
                //             width: 0,
                //           ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 27 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.nftItemRx.value.nftMetadata.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText2!.copyWith(
                            color: SatorioColor.textBlack,
                            fontSize: 20.0 * coefficient,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10 * coefficient,
                      // ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //     Container(
                      //       width: 20 * coefficient,
                      //       height: 20 * coefficient,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         gradient: LinearGradient(
                      //           begin: Alignment.topRight,
                      //           end: Alignment.bottomLeft,
                      //           colors: [
                      //             SatorioColor.yellow_orange,
                      //             SatorioColor.tomato,
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 6 * coefficient,
                      //     ),
                      //     Expanded(
                      //       child: Text(
                      //         'roberto21',
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         style: textTheme.bodyText2!.copyWith(
                      //           color: SatorioColor.textBlack,
                      //           fontSize: 15.0 * coefficient,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 23 * coefficient,
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     controller.addToFavourite();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: SatorioColor.geraldine,
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 7,
                //       horizontal: 10,
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //     ),
                //   ),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       SvgPicture.asset(
                //         'images/heart.svg',
                //         width: 22 * coefficient,
                //         height: 22 * coefficient,
                //         color: Colors.white,
                //       ),
                //       SizedBox(
                //         width: 5 * coefficient,
                //       ),
                //       Text(
                //         '310',
                //         style: textTheme.bodyText2!.copyWith(
                //           color: Colors.white,
                //           fontSize: 16.0 * coefficient,
                //           fontWeight: FontWeight.w700,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'txt_description'.tr,
              style: textTheme.headline6!.copyWith(
                color: SatorioColor.charcoal,
                fontSize: 18 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Text(
                controller.nftItemRx.value.nftMetadata.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.charcoal,
                  fontSize: 17 * coefficient,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24 * coefficient,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
              bottom: 20 + Get.mediaQuery.padding.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              color: SatorioColor.alice_blue,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                !controller.nftItemRx.value.onSale
                    ? Container()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'txt_current_price'.tr,
                            style: textTheme.bodyText2!.copyWith(
                              color: SatorioColor.charcoal,
                              fontSize: 15 * coefficient,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Obx(
                            () => Text(
                              isAndroid
                                  ? '${controller.nftItemRx.value.buyNowPrice.toStringAsFixed(2)} SAO'
                                  : '${controller.itemPrice.value} USD',
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
                  width: 36 * coefficient,
                ),
                controller.nftItemRx.value.onSale
                    ? Expanded(
                        child: Obx(
                          () => controller.isOwner.value
                              ? Container()
                              : ElevatedGradientButton(
                                  text: isAndroid
                                      ? 'txt_to_marketplace'.tr
                                      : 'txt_buy_nft'.tr,
                                  isInProgress: controller.isBuyRequested.value,
                                  onPressed: () {
                                    isAndroid
                                        ? controller.toMarketplace(controller
                                            .nftItemRx.value.mintAddress)
                                        : controller.buyInAppProduct();
                                  },
                                ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
