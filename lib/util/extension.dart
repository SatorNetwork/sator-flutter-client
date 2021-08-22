import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

extension Format on String {
  String format(List args) {
    return sprintf(this, args);
  }
}

extension Ellipsize on String {
  String ellipsize({int startCount = 6, int endCount = 6}) {
    if (this.length <= startCount + endCount)
      return this;
    else
      return '${this.substring(0, startCount)}...${this.substring(length - endCount, length)}';
  }
}

extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension EmailValidation on String {
  bool isEmail() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}

extension DoubleParse on String {
  double? tryParse() {
    String locale = Get.deviceLocale.toString();
    try {
      return NumberFormat.decimalPattern(locale).parse(this).toDouble();
    } catch (FormatException) {
      return null;
    }
  }
}
