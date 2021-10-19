import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final NftItemController controller;

  const CheckoutBottomSheet(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'txt_complete_checkout'.tr,
            style: textTheme.headline3!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 28 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'txt_item'.tr,
                  textAlign: TextAlign.start,
                  style: textTheme.bodyText2!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 18 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'txt_total'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 18 * coefficient,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8 * coefficient,
          ),
          Divider(
            height: 2,
            color: SatorioColor.alice_blue,
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Obx(
                  () => Image.network(
                    controller.nftItemRx.value.imageLink,
                    fit: BoxFit.cover,
                    width: 80 * coefficient,
                    height: 80 * coefficient,
                  ),
                ),
              ),
              SizedBox(
                width: 10 * coefficient,
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.nftItemRx.value.name,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10 * coefficient,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      '${controller.nftItemRx.value.buyNowPrice.toStringAsFixed(2)} SAO',
                      style: textTheme.bodyText2!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15 * coefficient,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Text(
                  //   '\$100.92',
                  //   style: textTheme.bodyText2!.copyWith(
                  //     color: SatorioColor.mischka,
                  //     fontSize: 14 * coefficient,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Divider(
            height: 2,
            color: SatorioColor.alice_blue,
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Checkbox(
                  activeColor: SatorioColor.interactive,
                  value: controller.termsOfUseCheck.value,
                  onChanged: (value) {
                    controller.termsOfUseCheck.toggle();
                  },
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'txt_checkout_description'.tr,
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 15 * coefficient,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'txt_terms'.tr,
                        style: textTheme.bodyText1!.copyWith(
                          fontSize: 15 * coefficient,
                          fontWeight: FontWeight.w500,
                          color: SatorioColor.interactive,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.toTermsOfUse();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Divider(
            height: 2,
            color: SatorioColor.alice_blue,
          ),
          SizedBox(
            height: 24 * coefficient,
          ),
          Obx(
            () => ElevatedGradientButton(
              text: 'txt_checkout'.tr,
              isEnabled: controller.termsOfUseCheck.value,
              isInProgress: controller.isBuyRequested.value,
              onPressed: () {
                controller.buy();
              },
            ),
          ),
          SizedBox(
            height: 12 * coefficient,
          ),
          BorderedButton(
            text: 'txt_cancel'.tr,
            textColor: SatorioColor.interactive,
            borderColor: SatorioColor.interactive,
            borderWidth: 2,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
