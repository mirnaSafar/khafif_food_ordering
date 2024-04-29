import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class PaymentEndPoints {
  static String getPaymentMethods =
      NetworkConfig.getFullApiRoute('payment_methods');
}
