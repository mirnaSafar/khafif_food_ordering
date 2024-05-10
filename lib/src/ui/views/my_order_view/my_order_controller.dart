import 'dart:async';

import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/order_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_view.dart';
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
              (l) => checkTokenIsExpiredToShowLoginWarning(
                  apiMessage: l,
                  function: () {
                    l.toLowerCase().contains('sale order')
                        ? null
                        : CustomToast.showMessage(
                            messageType: MessageType.REJECTED,
                            message: l,
                          );
                  }),
              (r) {
                myOrders.clear();
                myOrders.addAll(r);
                formatMyOrderStatus();
              },
            ),
          ),
    );
  }

  getMyOrderCart({
    required int orderID,
  }) {
    runFullLoadingFutuerFunction(
      function: OrdersRepository().getOrder(id: orderID).then(
            (value) => value.fold(
              (l) => checkTokenIsExpiredToShowLoginWarning(
                  apiMessage: l,
                  function: () => CustomToast.showMessage(
                        messageType: MessageType.REJECTED,
                        message: l,
                      )),
              (r) {
                storage.setCart(r);
                cartService.calcCartCount(cart: r);
                Get.put(CartController(customerCart: r.obs));
                cartStreamController.add(r);
                Get.to(ConfirmOrderView(
                  showMyOrderCart: true,
                ));
              },
            ),
          ),
    );
  }

  final StreamController<CustomerCartModel> cartStreamController =
      StreamController<CustomerCartModel>();

  Stream<CustomerCartModel> cartStream({required int orderID}) async* {
    while (true) {
      CustomerCartModel cart = cartService.cart.value!;
      Future.delayed(
        const Duration(milliseconds: 5000),
        () {
          OrdersRepository()
              .getOrder(id: orderID)
              .then((value) => value.fold((l) => null, (r) {
                    cart = r;
                  }));
        },
      );
      yield cart;
    }
  }

  RxList<OrderStatusEnum> formattedOrderStatus = <OrderStatusEnum>[].obs;

  formatMyOrderStatus() {
    for (var order in myOrders) {
      switch (order.state) {
        case "Quotation Sent":
          formattedOrderStatus.add(OrderStatusEnum.READY);
          break;
        case "Quotation":
          formattedOrderStatus.add(OrderStatusEnum.UNDERDELIVERY);
          break;
        case "Sales Order":
          formattedOrderStatus.add(OrderStatusEnum.CANCELED);
          break;

        default:
          formattedOrderStatus.add(OrderStatusEnum.UNDERDELIVERY);
          break;
      }
    }
  }
}
