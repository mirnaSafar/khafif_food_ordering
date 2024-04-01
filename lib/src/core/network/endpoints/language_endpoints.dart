import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class LanguageEndpoints {
  static String getLanguage = NetworkConfig.getFullApiRoute('languages');
  static String setLanguage =
      NetworkConfig.getFullApiRoute('customer/update_lang');
}
