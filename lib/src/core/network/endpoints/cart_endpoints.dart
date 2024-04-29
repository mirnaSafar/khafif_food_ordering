import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class CartEnpoints {
  static String getCart = NetworkConfig.getFullApiRoute('cart');
  static String addToCart = NetworkConfig.getFullApiRoute('addLine');
  static String updateOrder = NetworkConfig.getFullApiRoute('updateLine');
  static String deleteOrder = NetworkConfig.getFullApiRoute('deleteLine/');
}
