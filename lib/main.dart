import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/app_binding.dart';
import 'package:satorio/controller/splash_controller.dart';
import 'package:satorio/translation/sator_translation.dart';
import 'package:satorio/ui/page_widget/splash_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, 'images/bg/splash.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, 'images/splash.svg'),
      null,
    );
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'images/sator_colored.svg'),
      null,
    );

    runApp(GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(seconds: 0),
      enableLog: true,
      opaqueRoute: null,
      popGesture: null,
      theme: lightTheme,
      translations: SatorioTranslation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      supportedLocales: [
        Locale('en'),
      ],
      home: SplashPage(),
      onInit: () {
        Get.lazyPut<SplashController>(() => SplashController());
      },
    ));
  });
}
