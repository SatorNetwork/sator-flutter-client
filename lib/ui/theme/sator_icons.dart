import 'package:flutter/widgets.dart';

// GUIDE: https://dev.to/techwithsam/how-to-add-your-own-custom-icons-in-your-flutter-application-made-easy-1bnj
class SatorIcons {
  SatorIcons._();

  static const _kFontFam = 'SatorIcons';
  static const String? _kFontPkg = null;

  static const IconData watch =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData logo =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData scan =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData nft =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData wallet =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData profile =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData exit =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
