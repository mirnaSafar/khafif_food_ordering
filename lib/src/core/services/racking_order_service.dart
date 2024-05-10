import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';

class TrackingOrderService {
  StreamController<CustomerCartModel> trackingOrderController =
      StreamController<CustomerCartModel>.broadcast();
  final int orderID;
  TrackingOrderService(this.orderID) {
    Stream<CustomerCartModel> cartStream() async* {
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

    cartStream().listen((event) {
      trackingOrderController.add(event);
    });
  }
}
