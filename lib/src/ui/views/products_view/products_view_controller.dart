import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/banner_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/category_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/order_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/delivery_options_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/banner_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/category_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/products_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/search_product_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/select_order_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import '../../../core/app/app_config/colors.dart';
import '../../../core/services/base_controller.dart';

class ProductsViewController extends BaseController {
  TextEditingController searchController = TextEditingController();
  RxInt produtSelected = (-1).obs;
  RxInt orderOptionSelected = (1).obs;
  Rx<Color> backgroundColor = AppColors.mainWhiteColor.obs;
  RxInt current = 0.obs;
  double? height;
  double? width;
  ProductTemplateModel? product;

  RxInt sliderIndex = 0.obs;
  RxInt categoryIndex = (-1).obs;
  RxList<ProductTemplateModel> productsList = <ProductTemplateModel>[].obs;
  RxList<ProductTemplateModel> searchProductsList =
      <ProductTemplateModel>[].obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  List<List<CategoryModel>> carouselItems = [];

  RxList<ProductTemplateModel> favoritesList = <ProductTemplateModel>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    // Future.delayed(const Duration(seconds: 3), () {
    //
    //   update();
    // });
    if (storage.isLoggedIn) {
      favoriteService.getFavorites();
      cartController.getCart();
    }
    getAllCategories();
    getAllProducts();
    getBanners();
    update();
  }

  RxBool get isShimmerLoader =>
      operationType.contains(OperationType.PRODUCT).obs;
  RxBool get isCategoriesShimmerLoader =>
      operationType.contains(OperationType.CATEGORY).obs;

  RxBool get isLoading =>
      operationType.contains(OperationType.PRODUCTNEXTPAGE).obs;

  void toggleFavorites(ProductTemplateModel product) {
    favoriteService.toggleFavorites(product);
    favoritesList.value = favoriteService.favoritesList;
  }

  bool isFavorite(ProductTemplateModel product) {
    return favoriteService.isFavorite(product);
  }

  Future getAllCategories() {
    if (isOnline) {
      return runLoadingFutuerFunction(
          type: OperationType.CATEGORY,
          function: Future(() => CategoriesRepository().getAll().then(
                (value) {
                  value.fold((l) {
                    CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      message: l,
                    );
                    // isCategoriesShimmerLoader.value = false;
                  }, (r) {
                    categoriesList.clear();
                    categoriesList.addAll(r);
                    carouselItems.clear();
                    for (int i = 0; i < categoriesList.length; i += 4) {
                      int end = (i + 4 < categoriesList.length)
                          ? i + 4
                          : categoriesList.length;
                      carouselItems.add(categoriesList.sublist(i, end));
                    }
                  });
                },
              )));
    }
    return Future(() => null);
  }

  Future getAllProducts() {
    productsList.clear();
    searchProductsList.clear();

    return runLoadingFutuerFunction(
        type: OperationType.PRODUCT,
        function: Future(() => ProductsRepository()
                .getProductsTemplates(
              page: 1,
              perPage: perPage.value,
            )
                .then(
              (value) {
                value.fold((l) {
                  CustomToast.showMessage(
                    messageType: MessageType.REJECTED,
                    message: l,
                  );
                  //
                }, (r) {
                  productsList.clear();

                  productsList.addAll(r[0]);
                  totalPages.value = r[1].totalPages!;
                  currentPage.value = r[1].currentPage!;
                });
              },
            )));
  }

  RxInt currentPage = 1.obs;
  RxInt perPage = 6.obs;
  RxInt totalPages = 1.obs;

  Future fetchNextPage({int? id}) async {
    if (!isLoading.value && currentPage.value < totalPages.value) {
      isOffline ? operationType.remove(OperationType.PRODUCTNEXTPAGE) : null;
      checkConnection(() {
        currentPage.value++;
        runLoadingFutuerFunction(
            type: OperationType.PRODUCTNEXTPAGE,
            function: Future(() => id != null
                ? ProductsRepository()
                    .getProductsTemplatesByCategory(
                    id: id,
                    page: currentPage.value,
                    perPage: perPage.value,
                  )
                    .then(
                    (value) {
                      value.fold((l) {
                        CustomToast.showMessage(
                          messageType: MessageType.REJECTED,
                          message: l,
                        );
                      }, (r) {
                        productsList.addAll(r[0]);

                        //
                      });
                    },
                  )
                : ProductsRepository()
                    .getProductsTemplates(
                    page: currentPage.value,
                    perPage: perPage.value,
                  )
                    .then(
                    (value) {
                      value.fold((l) {
                        CustomToast.showMessage(
                          messageType: MessageType.REJECTED,
                          message: l,
                        );

                        //
                      }, (r) {
                        productsList.addAll(r[0]);

                        //
                      });
                    },
                  )));
      });
    }
  }

  Future getProductsByCategory({required int id}) {
    operationType.remove(OperationType.PRODUCTNEXTPAGE);
    productsList.clear();
    searchProductsList.clear();
    return runLoadingFutuerFunction(
        type: OperationType.PRODUCT,
        function: Future(() => ProductsRepository()
                .getProductsTemplatesByCategory(
              id: id,
              page: 1,
              perPage: perPage.value,
            )
                .then(
              (value) {
                value.fold((l) {
                  CustomToast.showMessage(
                    messageType: MessageType.REJECTED,
                    message: l,
                  );
                }, (r) {
                  productsList.clear();
                  productsList.addAll(r[0]);
                  totalPages.value = r[1].totalPages!;
                  currentPage.value = r[1].currentPage!;
                });
              },
            )));
  }

  RxList<BannerModel> bannerList = <BannerModel>[].obs;
  RxBool get bannerLoading => operationType.contains(OperationType.BANNER).obs;

  getBanners() {
    runLoadingFutuerFunction(
        type: OperationType.BANNER,
        function: BannerRepository().getBanner().then((value) => value.fold(
                (l) => CustomToast.showMessage(
                    message: l, messageType: MessageType.WARNING), (r) {
              bannerList.clear();
              bannerList.addAll(r);
            })));
  }

  changeBackgroundcolor(int index) {
    backgroundColor.value = produtSelected.value == index
        ? AppColors.mainAppColor
        : AppColors.mainWhiteColor;
  }

  RxList<ProductTemplateModel> get products =>
      searchProductsList.isNotEmpty ? searchProductsList : productsList;
  Future searchProducts({required String query}) {
    searchProductsList.clear();
    operationType.remove(OperationType.PRODUCTNEXTPAGE);
    produtSelected.value = -1;
    return runLoadingFutuerFunction(
        type: OperationType.PRODUCT,
        function:
            Future(() => SearchProductsRepository().getAll(query: query).then(
                  (value) {
                    value.fold((l) {
                      searchProductsList.clear();
                      CustomToast.showMessage(
                        messageType: MessageType.REJECTED,
                        message: l,
                      );
                      //
                    }, (r) {
                      searchProductsList.clear();

                      searchProductsList.addAll(r);
                    });
                  },
                )));
  }
}
