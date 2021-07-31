import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {this.controller,
      this.inputTitle = '',
      this.keyboardType = TextInputType.text,
      this.hintText,
      this.obscureText = false,
      this.errorText,
      this.icon,
      this.onPressedIcon});

  final TextEditingController? controller;
  final String inputTitle;
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final String? errorText;
  final Widget? icon;
  final VoidCallback? onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          inputTitle,
          style: textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w600, color: SatorioColor.textBlack),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
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
            style: textTheme.bodyText1!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              suffixIcon: icon == null
                  ? null
                  : IconButton(
                      onPressed: onPressedIcon,
                      icon: icon!,
                    ),
              hintStyle: textTheme.bodyText1!.copyWith(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w400,
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
