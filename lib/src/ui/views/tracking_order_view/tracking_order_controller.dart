import 'dart:async';

import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';

class OrderStatusController extends BaseController {
  Rx<CustomerCartModel> updatedCart;
  OrderStatusController(this.updatedCart);
  getMyOrderCart({
    required int orderID,
  }) {
    runLoadingFutuerFunction(
      function: OrdersRepository().getOrder(id: orderID).then(
            (value) => value.fold(
              (l) => updatedCart.value,
              (r) {
                print(updatedCart.value.state);
                updatedCart.value = r;
              },
            ),
          ),
    );
  }

  @override
  void onInit() {
    super.onInit();

    Timer.periodic(const Duration(seconds: 10), (timer) {
      getMyOrderCart(orderID: updatedCart.value.id!);
    });
  }
}
