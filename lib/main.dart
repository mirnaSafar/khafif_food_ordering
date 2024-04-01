import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/firebase_options.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_theme.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/favorites_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/location_service.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/app/my_app.dart';
import 'src/core/app/my_app_controller.dart';
import 'src/core/services/cart_services.dart';
import 'src/data/repositories/shared_preference_repository.dart';
import 'src/core/services/connectivity_service.dart';
import 'src/core/services/notifacation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });
  Get.put(SharedPreferenceRepository());
  Get.put(SplashController());

  Get.put(CartService());

  Get.put(LocationService());

  // Get.find<SharedPreferences>().clear();
  // storage.globalSharedPreference.clear();

  Get.put(ConnectivityService());
  Get.put(MyAppController());
  Get.put(FavoriteService());
  Get.put(AppTheme());

  Get.put(NotificationService());
  Get.put(ProductsViewController());
  Get.put(DateTimeController());
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAppCheck.instance.activate(
      // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
      // argument for `webProvider`
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Safety Net provider
      // 3. Play Integrity provider
      androidProvider: AndroidProvider.debug,
      // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Device Check provider
      // 3. App Attest provider
      // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
      appleProvider: AppleProvider.appAttest,
    );
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());
}
