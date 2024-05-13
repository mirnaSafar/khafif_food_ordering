import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class SetteingsController extends GetxController {
  RxBool receiveNotification = storage.isReceiveNotifications().obs;

  toogleNotificationStatus() {
    receiveNotification.value = !receiveNotification.value;
    storage.recieveNotifications(receiveNotification.value);
    receiveNotification.value
        ? notificationService.registerdFCMToken()
        : notificationService.deleteFcmToken();
  }
}
