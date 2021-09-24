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

extension LinkValidation on String {
  bool isLink() {
    // return Uri.tryParse(this)?.isAbsolute ?? false;
    return RegExp(
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
      caseSensitive: false,
    ).hasMatch(this);
  }
}

extension StringParseHelper on String {
  double? tryParse() {
    String locale = Get.deviceLocale.toString();
    try {
      return NumberFormat.decimalPattern(locale).parse(this).toDouble();
    } catch (FormatException) {
      return null;
    }
  }
}

extension JsonParseHelper on Map {
  String parseValueAsString(String key, {String defValue = ''}) {
    return this[key] == null ? defValue : this[key];
  }

  bool parseValueAsBool(String key, {bool defValue = false}) {
    return this[key] == null ? defValue : this[key];
  }

  int parseValueAsInt(String key, {int defValue = 0}) {
    return this[key] == null ? defValue : this[key];
  }

  double parseValueAsDouble(String key, {double defValue = 0.0}) {
    if (this[key] == null)
      return defValue;
    else if (this[key] is int)
      return (this[key] as int).toDouble();
    else
      return this[key];
  }

  DateTime? tryParseValueAsDateTime(String key) {
    DateTime? result;
    if (this[key] != null) {
      result = DateTime.tryParse(this[key]);
    }
    return result;
  }
}
