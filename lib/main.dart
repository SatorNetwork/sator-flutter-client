import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/app_binding.dart';
import 'package:satorio/binding/splash_binding.dart';
import 'package:satorio/translation/sator_translation.dart';
import 'package:satorio/ui/page_widget/splash_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
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
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashPage(),
          binding: SplashBinding(),
        ),
      ],
    ));
  });
}
