import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';

import '../services/base_controller.dart';

class MyAppController extends BaseController {
  Rx<ConnectivityStatus> connectivityStatus = ConnectivityStatus.ONLINE.obs;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus.value = value;
  }

  void listenForConnectivityStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;

      checkConnection(() {
        if (Get.isRegistered<ProductsViewController>()) homeRefreshingMethod();
        !notShowOnlineMessageOnAppStart.value
            ? showSnackbarText(tr("key_bot_toast_online"))
            : notShowOnlineMessageOnAppStart.value = false;
      });
    });
  }

  RxBool notShowOnlineMessageOnAppStart = true.obs;
  @override
  void onInit() {
    listenForConnectivityStatus();

    super.onInit();
  }
}
