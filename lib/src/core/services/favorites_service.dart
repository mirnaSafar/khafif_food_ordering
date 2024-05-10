import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/favorite_product_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/favorites_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

class FavoriteService extends BaseController {
  RxList<ProductTemplateModel> favoritesList = storage.getFavoritesList().obs;
  RxList<FavoriteProductModel> favoritesModels = <FavoriteProductModel>[].obs;
  RxBool get isFavoriteLoading =>
      operationType.contains(OperationType.FAVORITE).obs;

  void toggleFavorites(ProductTemplateModel product) {
    favoritesList.firstWhereOrNull(
              (product1) => product.id == product1.id!,
            ) !=
            null
        ? removeFromFavorites(product)
        : addToFavorites(product);
  }

  bool isFavorite(ProductTemplateModel product) {
    return favoritesList.firstWhereOrNull(
              (product1) => product.id == product1.id!,
            ) !=
            null
        ? true
        : false;
  }

  Future addToFavorites(ProductTemplateModel product) {
    return runFullLoadingFutuerFunction(
        type: OperationType.FAVORITE,
        function: Future(() => FavoritesRepository().add(id: product.id!).then(
              (value) {
                value.fold((l) {
                  CustomToast.showMessage(
                    messageType: MessageType.REJECTED,
                    message: l,
                  );
                  //
                }, (r) {
                  CustomToast.showMessage(
                    messageType: MessageType.SUCCESS,
                    message: tr('favorite_added_lb'),
                  );
                  getFavorites();
                  favoritesList.add(product);
                  storage.setFavoritesList(favoritesList);
                });
              },
            )));
  }

  removeFromFavorites(ProductTemplateModel product) {
    FavoriteProductModel? favoriteProductModel = favoritesModels
        .firstWhereOrNull((element) => element.productId!.id == product.id);
    if (favoriteProductModel != null) {
      runFullLoadingFutuerFunction(
          type: OperationType.FAVORITE,
          function: Future(() =>
              FavoritesRepository().remove(id: favoriteProductModel.id!).then(
                (value) {
                  value.fold((l) {
                    CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      message: l,
                    );
                  }, (r) {
                    CustomToast.showMessage(
                      messageType: MessageType.SUCCESS,
                      message: tr('favorite_removed_lb'),
                    );
                    getFavorites();
                    favoritesList
                        .removeWhere((product1) => product.id == product1.id!);
                    storage.setFavoritesList(favoritesList);
                  });
                },
              )));
    }
  }

  getFavorites() {
    runLoadingFutuerFunction(
        type: OperationType.FAVORITE,
        function: Future(() => FavoritesRepository().getAll().then((value) {
              value.fold((l) {
                checkTokenIsExpiredToShowLoginWarning(
                    apiMessage: l,
                    function: () => CustomToast.showMessage(
                          messageType: MessageType.REJECTED,
                          message: l,
                        ));
              }, (r) {
                // CustomToast.showMessage(
                //   messageType: MessageType.SUCCESS,
                //   message: 'get Successfully',
                // );
                favoritesList.clear();
                favoritesModels.clear();
                favoritesModels.addAll(r);
                for (var element in r) {
                  favoritesList.add(
                    ProductTemplateModel.fromJson(element.productId!.toJson()),
                  );
                }
              });
            })));
  }
}
