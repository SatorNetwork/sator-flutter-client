import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_item_detail_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class NftItemDetailPage extends GetView<NftItemDetailController> {
  get _heightTop => Get.mediaQuery.padding.top + kToolbarHeight;

  get _heightData =>
      (34 + 48 + 20) +
      (24 + (17 + 4) + 8 + (18 + 4) + 20 + 20 + 10 + (2 * (18 + 4)) + 89) *
          coefficient;

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
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    // color: SatorioColor.acadia,
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
                      child: Image.asset(
                        'images/tmp_nft_item.png',
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 89 * coefficient,
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
                                Text(
                                  'An Electric Storm (1/1 NFT + AR physical, 2021)',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyText2!.copyWith(
                                    color: SatorioColor.textBlack,
                                    fontSize: 18.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 10 * coefficient,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 20 * coefficient,
                                      height: 20 * coefficient,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            SatorioColor.yellow_orange,
                                            SatorioColor.tomato,
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6 * coefficient,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'roberto21',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.bodyText2!.copyWith(
                                          color: SatorioColor.textBlack,
                                          fontSize: 15.0 * coefficient,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 23 * coefficient,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.addToFavourite();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: SatorioColor.geraldine,
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'images/heart.svg',
                                  width: 22 * coefficient,
                                  height: 22 * coefficient,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5 * coefficient,
                                ),
                                Text(
                                  '310',
                                  style: textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.0 * coefficient,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
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
                      child: Text(
                        'Transaction was sent',
                        style: textTheme.bodyText2!.copyWith(
                          color: SatorioColor.charcoal,
                          fontSize: 17 * coefficient,
                          fontWeight: FontWeight.w400,
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
                        bottom: 34,
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
                          Column(
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
                              Text(
                                '15.00 SAO',
                                style: textTheme.bodyText2!.copyWith(
                                  color: SatorioColor.textBlack,
                                  fontSize: 15 * coefficient,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 36 * coefficient,
                          ),
                          Expanded(
                            child: ElevatedGradientButton(
                              text: 'txt_buy'.tr,
                              onPressed: () {
                                controller.buy();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 24,
              top: _heightTop,
              right: 24,
            ),
            height: Get.height - _heightData - _heightTop + 63 * coefficient,
            width: Get.width - 2 * 24,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                'images/tmp_nft_item.png',
                fit: BoxFit.cover,
                color: SatorioColor.acadia,
                colorBlendMode: BlendMode.plus,
              ),
            ),
          )
        ],
      ),
    );
  }
}
