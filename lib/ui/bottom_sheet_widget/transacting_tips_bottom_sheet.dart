import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class TransactingTipsBottomSheet extends StatelessWidget {
  final controller;

  const TransactingTipsBottomSheet(this.controller, this.review, {
    this.name,
  });

  final String? name;
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'txt_transacting_tips'.tr,
            textAlign: TextAlign.center,
            style: textTheme.headline4!.copyWith(
              color: SatorioColor.textBlack,
              fontSize: 20.0 * coefficient,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: SatorioColor.alice_blue2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                    child: SvgPicture.asset(
                      review.userAvatar,
                      height: 20,
                      width: 20,
                    )),
                SizedBox(
                  width: 6,
                ),
                Text(
                  '$name',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 15.0 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30 * coefficient,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _tipWidget('10'),
              _tipWidget('100'),
              _tipWidget('1000'),
            ],
          ),
          SizedBox(
            height: 20 * coefficient,
          ),
          _amountInput(),
          Spacer(),
          Obx(
                () =>
                ElevatedGradientButton(
                  text: 'txt_add'.tr,
                  isEnabled: controller.amountRx.value > 0,
                  isInProgress: controller.isRequested.value,
                  onPressed: () {
                    controller.sendReviewTip(review);
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _amountInput() {
    return TextFormField(
      controller: controller.amountController,
      obscureText: false,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      minLines: 1,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      enableSuggestions: false,
      autocorrect: false,
      style: textTheme.headline2!.copyWith(
        color: SatorioColor.textBlack,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        hintText: '0.00',
        errorText: '',
        hintStyle: textTheme.headline2!.copyWith(
          color: SatorioColor.textBlack.withOpacity(0.3),
          fontWeight: FontWeight.w700,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SatorioColor.interactive),
        ),
      ),
    );
  }

  Widget _tipWidget(String amount) {
    return InkWell(
      onTap: () {
        controller.setTipAmount(amount);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: SatorioColor.darkAccent.withOpacity(0.2),
        ),
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SatorioColor.interactive,
              ),
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
              width: 4,
            ),
            Text(
              '$amount.00',
              textAlign: TextAlign.center,
              style: textTheme.bodyText1!.copyWith(
                color: SatorioColor.textBlack,
                fontSize: 15.0 * coefficient,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
