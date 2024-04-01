import '../network_config.dart';

class UserEndpoints {
  static String login = NetworkConfig.getFullApiRoute('login');
  static String signup = NetworkConfig.getFullApiRoute('customer');
  static String verify = NetworkConfig.getFullApiRoute('verify');
  static String addAddress = NetworkConfig.getFullApiRoute('addAddress');
}
