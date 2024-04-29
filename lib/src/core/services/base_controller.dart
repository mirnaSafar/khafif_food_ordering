import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFAULT.obs;
  RxList<OperationType> operationType = <OperationType>[].obs;
  set setRequestStatus(RequestStatus value) {
    requestStatus.value = value;
  }

  set setOperationType(OperationType value) {
    operationType.addIf(!operationType.contains(value), value);
  }

  Future runFutuerFunction({required Future function}) async {
    checkConnection(() async {
      await function;
    });
  }

  Future runLoadingFutuerFunction(
      {required Future function,
      OperationType? type = OperationType.NONE}) async {
    setRequestStatus = RequestStatus.LOADING;
    setOperationType = type!;
    await function;
    setRequestStatus = RequestStatus.DEFAULT;
    setOperationType = OperationType.NONE;
    operationType.remove(type);
  }

  Future runFullLoadingFutuerFunction(
      {required Future function,
      OperationType? type = OperationType.NONE}) async {
    checkConnection(() async {
      customLoader();
      await function;
      BotToast.closeAllLoading();
    });
  }
}
