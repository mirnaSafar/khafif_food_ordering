import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class SetteingsController extends GetxController {
  RxBool receiveNotification = true.obs;

  toogleNotificationStatus() {
    receiveNotification.value = !receiveNotification.value;
    receiveNotification.value
        ? notificationService.registerdFCMToken()
        : notificationService.deleteFcmToken();
  }
}
