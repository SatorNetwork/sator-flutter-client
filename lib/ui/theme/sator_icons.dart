import 'package:flutter/widgets.dart';

// GUIDE: https://dev.to/techwithsam/how-to-add-your-own-custom-icons-in-your-flutter-application-made-easy-1bnj
class SatorIcons {
  SatorIcons._();

  static const _kFontFam = 'SatorIcons';
  static const String _kFontPkg = null;

  static const IconData logo =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
