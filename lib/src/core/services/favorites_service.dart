import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/favorite_product_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/favorites_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

class FavoriteService extends BaseController {
  RxList<ProductTemplateModel> favoritesList = storage.getFavoritesList().obs;

  void toggleFavorites(ProductTemplateModel product) {
    favoritesList.firstWhereOrNull(
              (product1) => product.id == product1.id!,
            ) !=
            null
        ? removeFromFavorites(product)
        : addToFavorites(product);

    storage.setFavoritesList(favoritesList);
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
    return runLoadingFutuerFunction(
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
                    message: 'added to favorites',
                  );
                  favoritesList.add(product);
                });
              },
            )));
  }

  Future removeFromFavorites(ProductTemplateModel product) {
    return runLoadingFutuerFunction(
        type: OperationType.FAVORITE,
        function:
            Future(() => FavoritesRepository().remove(id: product.id!).then(
                  (value) {
                    value.fold((l) {
                      CustomToast.showMessage(
                        messageType: MessageType.REJECTED,
                        message: l,
                      );
                    }, (r) {
                      CustomToast.showMessage(
                        messageType: MessageType.SUCCESS,
                        message: 'removed from favorites',
                      );
                      favoritesList.removeWhere(
                          (product1) => product.id == product1.id!);
                    });
                  },
                )));
  }

  getFavorites() {
    runLoadingFutuerFunction(
        type: OperationType.FAVORITE,
        function: Future(() => FavoritesRepository().getAll().then((value) {
              value.fold((l) {
                CustomToast.showMessage(
                  messageType: MessageType.REJECTED,
                  message: l,
                );
              }, (r) {
                CustomToast.showMessage(
                  messageType: MessageType.SUCCESS,
                  message: 'get Successfully',
                );
                favoritesList.value = r;
              });
            })));
  }
}
