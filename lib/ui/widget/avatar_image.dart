import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/util/links.dart';

class AvatarImage extends StatelessWidget {
  final String? avatarPath;
  final double width;
  final double height;

  AvatarImage(this.avatarPath, {required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    RegExpMatch? match =
        new RegExp(urlPattern, caseSensitive: false).firstMatch(avatarPath!);

    if (match == null) {
      return SvgPicture.asset(
        avatarPath ?? '',
        width: width * coefficient,
        height: height * coefficient,
        fit: BoxFit.fitWidth,
      );
    } else {
      return Image.network(
        avatarPath ?? '',
        height: width * coefficient,
        width: width * coefficient,
        fit: BoxFit.fitWidth,
      );
    }
  }
}
