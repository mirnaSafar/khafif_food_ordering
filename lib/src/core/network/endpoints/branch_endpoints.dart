import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class BranchEndpoints {
  static String getBranch = NetworkConfig.getFullApiRoute('orders/pickUp');
  static String getAllBranches = NetworkConfig.getFullApiRoute('allbranch');
  static String setBranch = NetworkConfig.getFullApiRoute('orders/setBranch');
}
