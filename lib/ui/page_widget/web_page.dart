import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends GetView<WebController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: null,
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: SatorioColor.darkAccent,
              size: 32,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          backgroundImage('images/bg/gradient.svg'),
          Container(
            constraints: BoxConstraints(
                minHeight: Get.mediaQuery.size.height -
                    (Get.mediaQuery.padding.top + kToolbarHeight)),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.loadUrl(webViewController);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
