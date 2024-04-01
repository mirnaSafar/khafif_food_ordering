import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';

class FavoritesController extends BaseController {
  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  RxList<ProductTemplateModel> favoritesList = favoriteService.favoritesList;
  getFavorites() {
    favoriteService.getFavorites();
  }

  toggleFavorites(ProductTemplateModel product) {
    favoriteService.toggleFavorites(product);
  }
}
