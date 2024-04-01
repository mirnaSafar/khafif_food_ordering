import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class OrderEndPoints {
  static String getMyOrders = NetworkConfig.getFullApiRoute('myorder');
  static String closeOrder = NetworkConfig.getFullApiRoute('orders/close');
  static String getOrderOptions = NetworkConfig.getFullApiRoute('delivery');
}
