import '../network_config.dart';

class UserAddressesEndpoints {
  static String addAddress = NetworkConfig.getFullApiRoute('addAddress');
  static String getAddresses = NetworkConfig.getFullApiRoute('Address');
  static String deleteAddresse =
      NetworkConfig.getFullApiRoute('deleteAddress/');
}
