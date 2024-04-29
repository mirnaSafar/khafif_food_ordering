import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class FcmTokenEndpoints {
  static String saveFcmToken = NetworkConfig.getFullApiRoute('save_fcm_token');
  static String getFcmToken = NetworkConfig.getFullApiRoute('get_fcm_token');
}
