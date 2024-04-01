import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_theme.dart';
import 'package:khafif_food_ordering_application/src/ui/views/intro_view/intro_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_screen_view.dart';
import 'package:provider/provider.dart';

import '../enums.dart';
import '../translation/app_translation.dart';
import '../utility/general_utils.dart';

late BuildContext globalContext;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    globalContext = context;

    return StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.ONLINE,
        create: (context) =>
            connectivityService.connectivityStatusController.stream,
        child: Obx(() {
          print(appTheme.isDarkMode.value);
          return GetMaterialApp(
              navigatorKey: Get.key,
              // initialRoute: '/',
              // routes: {
              //   '/': (context) => const ProductsView(),
              //   // Include other named routes if needed
              // },
              defaultTransition: Transition.circularReveal,
              transitionDuration: const Duration(milliseconds: 12),
              title: 'Flutter Demo',
              builder: BotToastInit(),
              locale: getLocal(),
              fallbackLocale: getLocal(),
              translations: AppTranslation(), //1. call BotToastInit
              navigatorObservers: [BotToastNavigatorObserver()],
              themeMode: appTheme.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              // initialBinding: BindingsBuilder(() {
              //   Get.put(AppTheme());
              // }),
              home: const SplashScreenView());
          // : const ProductsView());
        }));
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar_001') {
    return const Locale('ar', 'SA');
  } else if (storage.getAppLanguage() == 'tr') {
    return const Locale('tr', 'TR');
  } else {
    return const Locale('en', 'US');
  }
}
