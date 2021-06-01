import 'package:sprintf/sprintf.dart';

extension Format on String {
  String format(List args) {
    return sprintf(this, args);
  }
}
