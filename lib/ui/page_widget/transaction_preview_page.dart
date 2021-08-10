import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/transaction_preview_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class TransactionPreviewPage extends GetView<TransactionPreviewController> {
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
          'txt_preview'.tr,
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
              size: 32,
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
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
            height: Get.mediaQuery.size.height -
                (Get.mediaQuery.padding.top + kToolbarHeight),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: SatorioColor.alice_blue,
                        ),
                        child: Card(
                          elevation: 12,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.black.withOpacity(0.3),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'txt_asset'.tr,
                                        style: textTheme.bodyText1!.copyWith(
                                          fontSize: 17 * coefficient,
                                          fontWeight: FontWeight.w400,
                                          color: SatorioColor.textBlack,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: SatorioColor.mauve,
                                      ),
                                      child: Obx(
                                        () => Text(
                                          controller.transferRx.value.assetName,
                                          textAlign: TextAlign.end,
                                          style: textTheme.headline5!.copyWith(
                                            fontSize: 15 * coefficient,
                                            fontWeight: FontWeight.w600,
                                            color: SatorioColor.brand,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15 * coefficient,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                SizedBox(
                                  height: 18 * coefficient,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'txt_amount'.tr,
                                      style: textTheme.bodyText1!.copyWith(
                                        fontSize: 17 * coefficient,
                                        fontWeight: FontWeight.w400,
                                        color: SatorioColor.textBlack,
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.transferRx.value.amount
                                              .toString(),
                                          textAlign: TextAlign.end,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.headline5!.copyWith(
                                            fontSize: 17 * coefficient,
                                            fontWeight: FontWeight.w600,
                                            color: SatorioColor.textBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18 * coefficient,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                SizedBox(
                                  height: 18 * coefficient,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'txt_send_to'.tr,
                                      style: textTheme.bodyText1!.copyWith(
                                        fontSize: 17 * coefficient,
                                        fontWeight: FontWeight.w400,
                                        color: SatorioColor.textBlack,
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.transferRx.value
                                              .recipientAddress,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: textTheme.headline5!.copyWith(
                                            fontSize: 17 * coefficient,
                                            fontWeight: FontWeight.w600,
                                            color: SatorioColor.textBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18 * coefficient,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                SizedBox(
                                  height: 18 * coefficient,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'txt_fee'.tr,
                                      style: textTheme.bodyText1!.copyWith(
                                        fontSize: 17 * coefficient,
                                        fontWeight: FontWeight.w400,
                                        color: SatorioColor.textBlack,
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          '${controller.transferRx.value.fee} ${controller.transferRx.value.assetName}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: textTheme.headline5!.copyWith(
                                            fontSize: 17 * coefficient,
                                            fontWeight: FontWeight.w600,
                                            color: SatorioColor.textBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedGradientButton(
                        text: 'txt_send'.tr,
                        onPressed: () {
                          controller.send();
                        },
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
}
