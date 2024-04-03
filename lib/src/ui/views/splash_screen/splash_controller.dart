import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/delivery_options_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/select_order_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/intro_view/intro_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    getOrderDeliveryOptions();
    Future.delayed(
      const Duration(seconds: 5),
    ).then((value) {
      if (storage.getFirstLaunch()) {
        Get.off(const IntroWidget());

        storage.setFirstLaunch(false);
      } else {
        Get.off(const ProductsView());
      }
    });
  }

  RxBool get isOrderOptionsLoading =>
      operationType.contains(OperationType.PRODUCT).obs;
  RxList<DeliveryOptionsModel> orderDeliveryOptions =
      <DeliveryOptionsModel>[].obs;
  getOrderDeliveryOptions() {
    runLoadingFutuerFunction(
        type: OperationType.PRODUCT,
        function: OrderOptionsRepository().getDeliverOptions().then((value) =>
            value.fold(
                (l) => CustomToast.showMessage(
                    message: l, messageType: MessageType.WARNING), (r) {
              orderDeliveryOptions.clear();
              orderDeliveryOptions.addAll(r);
            })));
  }
}
