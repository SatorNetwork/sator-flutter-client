import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {this.controller,
      this.inputTitle,
      this.keyboardType = TextInputType.text,
      this.hintText,
      this.obscureText,
      this.icon,
      this.onPressedIcon});

  final TextEditingController controller;
  final String inputTitle;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final Function onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          inputTitle,
          style: textTheme.headline5.copyWith(
            color: SatorioColor.textBlack,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          decoration: BoxDecoration(
            color: SatorioColor.inputGrey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.next,
            style: textTheme.bodyText2.copyWith(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: icon == null
                  ? Container(
                      width: 30,
                    )
                  : IconButton(
                      onPressed: onPressedIcon,
                      icon: icon,
                    ),
              hintStyle: textTheme.bodyText2.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
