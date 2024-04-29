import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/services/cart_services.dart';
import 'package:khafif_food_ordering_application/src/core/services/connectivity_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/notifacation_service.dart';

import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/favorites_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/location_service.dart';

import '../../../core/app/my_app_controller.dart';

class SplashBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(CartService());

    Get.put(LocationService());

    // Get.find<SharedPreferences>().clear();
    // storage.globalSharedPreference.clear();

    Get.put(ConnectivityService());
    Get.put(MyAppController());
    Get.put(FavoriteService());

    Get.put(NotificationService());
    // Get.put(ProductsViewController());
    // Get.put(CartController());
    Get.put(DateTimeController());
  }
}
