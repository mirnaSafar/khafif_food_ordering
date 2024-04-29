import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';

class ProductsEndPoints {
  static String getProductTemplates =
      NetworkConfig.getFullApiRoute('product_templates/');
  static String getProductTemplatesByCategory =
      NetworkConfig.getFullApiRoute('product_templates/categories/');

  static String getProductVariants =
      NetworkConfig.getFullApiRoute('product_product/variants');
}
