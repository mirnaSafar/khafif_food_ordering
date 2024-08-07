// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_theme.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_binding.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_screen_view.dart';
import 'package:provider/provider.dart';

import '../enums.dart';
import '../translation/app_translation.dart';
import '../utility/general_utils.dart';

late BuildContext globalContext;

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.ONLINE,
        create: (context) =>
            connectivityService.connectivityStatusController.stream,
        child: Obx(() {
          print(appTheme.isDarkMode.value);
          return GetMaterialApp(
              initialBinding: SplashBinding(),
              navigatorKey: Get.key,
              defaultTransition: Transition.circularReveal,
              transitionDuration: Duration(milliseconds: 12),
              title: 'خفيف',
              builder: BotToastInit(),
              locale: getLocal(),
              fallbackLocale: getLocal(),
              translations: AppTranslation(), //1. call BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()],
              themeMode: appTheme.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              home: SplashScreenView());
          // :  ProductsView());
        }));
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar_001') {
    return Locale('ar', 'SA');
  } else if (storage.getAppLanguage() == 'tr') {
    return Locale('tr', 'TR');
  } else {
    return Locale('en', 'US');
  }
}
