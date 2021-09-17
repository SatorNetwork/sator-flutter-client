import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController extends GetxController {
  late final String url;

  WebViewController? webViewController;

  WebController() {
    WebArgument argument = Get.arguments as WebArgument;

    url = argument.url;
  }

  void back() {
    webViewController?.canGoBack().then((bool result) {
      result ? webViewController?.goBack() : Get.back();
    });
  }

  void loadUrl(WebViewController webViewController) {
    this.webViewController = webViewController;
    webViewController.loadUrl(url);
  }
}

class WebArgument {
  const WebArgument(this.url);

  final String url;
}
