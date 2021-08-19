import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

typedef AmountEnterCallback = void Function(double amount);

class StakeDialog extends StatelessWidget {
  StakeDialog(this.text, this.amountCurrency, this.buttonText, this.onPressed);

  final TextEditingController _amountController = TextEditingController();

  final String text;
  final String amountCurrency;
  final String buttonText;
  final AmountEnterCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              height: 32 * coefficient,
            ),
            TextFormField(
              controller: _amountController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: textTheme.headline1!.copyWith(
                color: Colors.black,
                fontSize: 34 * coefficient,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: SatorioColor.textBlack),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: SatorioColor.textBlack),
                ),
              ),
            ),
            SizedBox(
              height: 32 * coefficient,
            ),
            ElevatedGradientButton(
              text: buttonText,
              onPressed: () {
                try {
                  double amount =
                      NumberFormat().parse(_amountController.text).toDouble();
                  Get.back();
                  onPressed(amount);
                } catch (FormatException) {}

                // double? amount = double.tryParse(_amountController.text);
                // if (amount != null) {
                //   Get.back();
                //   onPressed(amount);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
