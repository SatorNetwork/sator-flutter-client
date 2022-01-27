import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_stake.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/decimal_text_input_formatter.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/links.dart';

typedef AmountEnterCallback = void Function(double amount);

class LockRewardsBottomSheet extends StatelessWidget {
  final String text;
  final String amountCurrency;
  final WalletStake? walletStake;
  final WalletDetail? walletDetail;
  final String buttonText;
  final AmountEnterCallback onPressed;

  final TextEditingController _amountController = TextEditingController();

  LockRewardsBottomSheet(this.text, this.amountCurrency, this.walletStake,
      this.walletDetail, this.buttonText, this.onPressed);

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
          SizedBox(
            height: 20 * coefficient,
          ),
          Row(
            children: [
              Text(
                text,
                style: textTheme.bodyText1!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 17.0 * coefficient,
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  amountCurrency,
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 17.0 * coefficient,
                      fontWeight: FontWeight.w600),
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
                'txt_rewards_multiply'.tr,
                style: textTheme.bodyText1!.copyWith(
                    color: SatorioColor.textBlack,
                    fontSize: 17.0 * coefficient,
                    fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Text(
                  '400%',
                  textAlign: TextAlign.end,
                  style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.interactive,
                      fontSize: 17.0 * coefficient,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30 * coefficient,
          ),
          _amountInput(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'txt_transaction_fee'.tr,
                  style: textTheme.bodyText1!.copyWith(
                      color: SatorioColor.textBlack,
                      fontSize: 12.0 * coefficient,
                      fontWeight: FontWeight.w400),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '35 SAO',
                  style: textTheme.bodyText1!.copyWith(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 12 * coefficient,
                    fontWeight: FontWeight.w700,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' / ',
                      style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: '\$24.92',
                      style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.interactive,
                        fontSize: 12 * coefficient,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          ElevatedGradientButton(
            text: buttonText,
            onPressed: () {
              double? amount = _amountController.text.tryParse();
              if (amount != null) {
                Get.back();
                onPressed(amount);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _amountInput() {
    return TextFormField(
      controller: _amountController,
      inputFormatters: [
        DecimalTextInputFormatter(decimalRange: 6),
        FilteringTextInputFormatter.allow(RegExp(amountPattern))
      ],
      obscureText: false,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      minLines: 1,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      enableSuggestions: false,
      autocorrect: false,
      style: textTheme.headline1!.copyWith(
        color: SatorioColor.textBlack,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        hintText: '0.00',
        errorText: '',
        hintStyle: textTheme.headline1!.copyWith(
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
}
