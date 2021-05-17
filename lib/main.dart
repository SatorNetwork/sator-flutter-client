import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/splash_controller.dart';
import 'package:satorio/translation/sator_translation.dart';
import 'package:satorio/ui/page_widget/splash_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(seconds: 0),
      enableLog: true,
      opaqueRoute: null,
      popGesture: null,
      theme: lightTheme,
      translations: SatorTranslation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      home: SplashPage(),
      onInit: () {
        Get.lazyPut<SplashController>(() => SplashController());
      },
    ));
  });
}
