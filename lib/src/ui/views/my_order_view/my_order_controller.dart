import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/order_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/widgets/order_status.dart';

class MyOrderController extends BaseController {
  RxList<OrderModel> myOrders = <OrderModel>[].obs;
  @override
  onInit() {
    getMyOrders();
    super.onInit();
  }

  RxBool get myOrdersLoading => operationType.contains(OperationType.order).obs;

  getMyOrders() {
    runLoadingFutuerFunction(
      type: OperationType.order,
      function: OrdersRepository().getAll().then(
            (value) => value.fold(
              (l) => CustomToast.showMessage(message: l),
              (r) {
                myOrders.clear();
                myOrders.addAll(r);
                formatMyOrderStatus();
              },
            ),
          ),
    );
  }

  getMyOrderCart({required int orderID}) {
    runFullLoadingFutuerFunction(
      function: OrdersRepository().getOrder(id: orderID).then(
            (value) => value.fold(
              (l) => CustomToast.showMessage(message: l),
              (r) {
                storage.setCart(r);
                cartService.calcCartCount(cart: r);
                Get.put(CartController(customerCart: r.obs));

                Get.to(const ConfirmOrderView(
                  showMyOrderCart: true,
                ));
              },
            ),
          ),
    );
  }

  RxList<OrderStatusEnum> formattedOrderStatus = <OrderStatusEnum>[].obs;

  formatMyOrderStatus() {
    for (var order in myOrders) {
      switch (order.state) {
        case "Ready":
          formattedOrderStatus.add(OrderStatusEnum.READY);
          break;
        case "Under Delivery":
          formattedOrderStatus.add(OrderStatusEnum.UNDERDELIVERY);
          break;
        case "Cancel":
          formattedOrderStatus.add(OrderStatusEnum.CANCELED);
          break;

        default:
          formattedOrderStatus.add(OrderStatusEnum.UNDERDELIVERY);
          break;
      }
    }
  }
}
