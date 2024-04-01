import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_variants_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/cart_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/products_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_controller.dart';

class ProductDetailsController extends BaseController {
  RxBool textExpanded = false.obs;
  RxString readingState = 'Read More'.obs;
  // RxString cartName = ''.obs;
  // RxString productImage = ''.obs;
  // RxInt productVariantsModel.value.id!, = (-1).obs;
  List<VariantValue>? toppings = [];

  RxInt count = 1.obs;
  RxDouble total = (0.0).obs;
  RxDouble plus = (0.0).obs;
  RxList<int> selectedVariantsItems = <int>[].obs;
  Rx<ProductVariantsModel> productVariantsModel = ProductVariantsModel().obs;
  ProductTemplateModel? product;
  ProductDetailsController({this.product});
  @override
  void onInit() {
    if (product != null) {
      // getProduct(id: product!.id!);
      calcTotal(price: product!.price.toString());
      selectedVariantsItems.value =
          List.filled(product!.variantValue!.length, -1);
      toppings = product!.variantValue;
      productVariantsModel.value = ProductVariantsModel(
        description: product!.description,
        id: product!.id,
        image: product!.image,
        name: product!.name,
        price: product!.price,
      );
      toppings!.isEmpty || toppings == null
          ? getProductVariant(variantIds: [product!.id!])
          : null;

      // cartName.value = product!.name ?? '';
      // productImage.value = product!.image ?? '';
      // productID.value = product!.id ?? -1;
    }

    super.onInit();
  }

  RxBool get productCanbeAddedToCart =>
      ((selectedVariantsItems.firstWhereOrNull(
                        (element) => element != -1,
                      ) !=
                      null &&
                  variantSelectedSuccessfully.isTrue) ||
              selectedVariantsItems.isEmpty)
          .obs;
  RxBool get isCarLoading => operationType.contains(OperationType.CART).obs;
  // CartController cartController = Get.put(CartController());
  addToCart() {
    runLoadingFutuerFunction(
        type: OperationType.CART,
        function: CartRepository()
            .addToCart(
                productID: productVariantsModel.value.id!,
                productQty: count.value)
            .then((value) => value.fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
                  if (cartService.cart.value == null) {
                    Get.put(CartController());
                    Get.find<CartController>().getCart(showLoader: false);
                  }
                  storage.setNewOrder(false);

                  cartService.addToCart(
                      afterAdd: () {
                        // cartController.setOderCount =
                        cartService.cartCount.value;
                        CustomToast.showMessage(
                            message: 'Added', messageType: MessageType.SUCCESS);
                      },
                      model: ProductTemplateModel(
                        calories: product!.calories,
                        description: productVariantsModel.value.description,
                        id: productVariantsModel.value.id,
                        image: productVariantsModel.value.image,
                        name: productVariantsModel.value.name,
                        price: product!.price! + plus.value,
                        variantValue: product!.variantValue,
                      ),
                      count: count.value);
                })));
  }

  RxBool variantSelectedSuccessfully = false.obs;
  getProductVariant({required List<int> variantIds}) {
    variantSelectedSuccessfully.value = false;
    runFullLoadingFutuerFunction(
        type: OperationType.CART,
        function: CartRepository()
            .getProductVariants(variantIds: variantIds)
            .then((value) => value.fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
                  // addToCart();
                  setTotalPlusPrice(
                    price: product!.price.toString(),
                  );
                  variantSelectedSuccessfully.value = true;
                  productVariantsModel.value = r;
                })));
  }

  RxBool get isShimmerLoader =>
      operationType.contains(OperationType.PRODUCT).obs;

  Future getProduct({required int id}) {
    return runFutuerFunction(
        // type: OperationType.PRODUCT,
        function: Future(() => ProductsRepository()
                .getProductsTemplates(id: id.toString(), page: 1)
                .then(
              (value) {
                value.fold((l) {
                  CustomToast.showMessage(
                    messageType: MessageType.REJECTED,
                    message: l,
                  );
                  //
                }, (r) {
                  product = r[0][0];
                });
              },
            )));
  }
  // void setCartName() {
  //   toppingsSet.value ;
  //   for (var i = 0; i < selectedVariantsItems.length; i++) {
  //     int toppingIndex = selectedVariantsItems[i];
  //     int? toppimgId =
  //         toppingIndex != -1 ? toppings![i].valueIds![toppingIndex].id : -1;

  //     toppingsSet.value += toppimgId!;
  //   }
  // }

  void setTotalPlusPrice({required String price}) {
    plus.value = 0;
    for (var i = 0; i < selectedVariantsItems.length; i++) {
      int toppingIndex = selectedVariantsItems[i];
      int index = toppingIndex != -1
          ? toppings![i].valueIds!.indexOf(toppings![i]
              .valueIds!
              .firstWhere((element) => element.id == toppingIndex))
          : -1;
      var toppingPlus =
          index != -1 ? toppings![i].valueIds![index].priceExtra : 0;
      plus.value += toppingPlus!.toDouble();
    }
    calcTotal(price: price);
  }

  // RxString get customizedCartName => toppingsSet.isNotEmpty
  //     ? '${cartName.value} ($toppingsSet)'.obs
  //     : cartName.value.obs;

  double calcTotal({required String price}) {
    total.value = (count.value * (double.parse(price) + plus.value));
    return total.toDouble();
  }

  double addToTotal({required String price, required double plus1}) {
    // total.value =  + plus1.toDouble();
    plus.value = plus1;
    calcTotal(price: price);
    return total.toDouble();
  }

  void changeCount({required bool incress}) {
    if (incress) {
      count++;
    } else {
      if (count > 1) count--;
    }
  }

  changeReadStatus() {
    textExpanded.value = !textExpanded.value;
    readingState.value =
        textExpanded.value ? tr('read_less_lb') : tr('read_more_lb');
  }
}
