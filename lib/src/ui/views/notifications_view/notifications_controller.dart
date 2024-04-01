 
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/data/models/notification_model.dart';

class NotificationsController extends BaseController {

  RxList<NotifictionModel> notificationsModel = <NotifictionModel>[].obs;

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  void getNotifications() {
    // runLoadingFutuerFunction(
        // function: NotificationsRepository().getAll().then((value) {
        //   value.fold((l) {
        //     CustomToast.showMessage(message: l , messageType: MessageType.REJECTED);
        //   }, (r) {
        //     notificationsModel.addAll(r);
        //   });
        // })
    // )
  }



}
