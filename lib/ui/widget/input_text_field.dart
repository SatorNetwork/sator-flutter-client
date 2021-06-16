import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';

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
  final Icon? icon;
  final VoidCallback? onPressedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          inputTitle,
          style: TextStyle(
            color: SatorioColor.textBlack,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
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
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              suffixIcon: icon == null
                  ? Container(
                      width: 30,
                    )
                  : IconButton(
                      onPressed: onPressedIcon,
                      icon: icon!,
                    ),
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 17,
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
