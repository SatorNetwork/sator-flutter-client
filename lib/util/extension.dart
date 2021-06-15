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
