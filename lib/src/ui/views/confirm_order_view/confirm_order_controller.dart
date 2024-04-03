import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/cart_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

class CartController extends BaseController {
  @override
  onInit() {
    customerCart == null ? getCart() : null;
    getSuggestedProducts();

    setOderCount =
        customerCart == null ? 0 : cartService.cartCustomerCount.value;
    super.onInit();
  }

  Rx<CustomerCartModel>? customerCart;

  CartController({this.customerCart});
  RxInt suggestedProductsIndex = (-1).obs;

  RxList<Line> cartProducts = <Line>[].obs;

  RxList<CartModel> get cartList => cartService.cartList;
  Rx<Line> selectedCart = Line().obs;
  Rx<CustomerCartModel?> cart = cartService.cart;

  RxString orderCount =
      '${cartService.cartCustomerCount.value < 10 ? '0' : ''}${cartService.cartCustomerCount.value} '
          .obs;

  set setOderCount(int count) {
    orderCount.value = '${count < 10 ? '0' : ''}$count';
  }

  void changeCount({required bool incress, required Line model}) {
    // cartService.changeCount(incress: incress, model: model);
  }

  void clearCart() {
    cartService.clearCart();
    setOderCount = cartService.cartCount.value;
  }

  RxBool get isCartLoading => (operationType.contains(OperationType.CART) ||
          operationType.contains(OperationType.PRODUCT))
      .obs;
  void removeFromCart(Line model) {
    cartService.removeFromCartList(
      CartModel(
          count: model.productUomQty!.toInt(),
          total: model.priceTotal!,
          product: ProductTemplateModel(
            calories: 0.0,
            description: model.productId!.description,
            id: model.productId!.id,
            image: model.productId!.image,
            name: model.productId!.name,
            price: model.productId!.price,
            variantValue: [VariantValue()],
          )),
    );
    setOderCount = cartService.cartCount.value;
  }

  RxList<ProductTemplateModel> suggestedProducts = <ProductTemplateModel>[].obs;

  getSuggestedProducts() {
    var filteredProducts = productsVieewController.productsList
        .where((element) => cartList
            .every((cartModel) => (element.id != cartModel.product!.id)))
        .toList();

    filteredProducts.shuffle();

    suggestedProducts.value = filteredProducts.length > 5
        ? filteredProducts.sublist(0, 5)
        : List.of(filteredProducts);
  }

  updateOrder({required bool incress}) {
    int qty = selectedCart.value.productUomQty!.toInt();

    incress ? qty += 1 : qty -= 1;

    runFullLoadingFutuerFunction(
        type: OperationType.PRODUCT,
        function: CartRepository()
            .updateOrder(
                productID: selectedCart.value.productId!.id!, productQty: qty)
            .then((value) => value.fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
                  // CustomToast.showMessage(
                  //     message: 'done', messageType: MessageType.SUCCESS);

                  // changeCount(incress: incress, model: selectedCart.value);
                  setOderCount = selectedCart.value.productUomQty!.toInt();
                  // Get.put(MyOrderController());
                  // myOrderController.getMyOrders();
                  getCart(
                      showLoader: true); // productsDetailsController.calcTotal(
                  //     price: selectedCart.value.product!.price.toString());
                })));
  }

  deleteOrder() {
    runFullLoadingFutuerFunction(
        type: OperationType.CART,
        function: CartRepository()
            .deleteOrder(
              productID: selectedCart.value.productId!.id!,
            )
            .then((value) => value.fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
                  CustomToast.showMessage(
                      message: 'Item deleted from cart',
                      messageType: MessageType.SUCCESS);
                  getCart(showLoader: true);
                  removeFromCart(selectedCart.value);
                  // Get.put(MyOrderController());
                  // myOrderController.getMyOrders();
                })));
  }

  getCart({bool? showLoader = false}) {
    if (!storage.getIsNewOrder()) {
      var runfunction = CartRepository().cart().then((value) => value.fold(
              (l) => CustomToast.showMessage(
                  message: l, messageType: MessageType.WARNING), (r) {
            storage.setCart(r);
            cartService.cart.value = r;
            customerCart = r.obs;
            selectedCart.value = cart.value?.line!.firstWhereOrNull(
                    (element) => element.lineId == selectedCart.value.lineId) ??
                Line();
            cartService.calcCartCount(cart: r);
            setOderCount = cartService.cartCustomerCount.value;
          }));

      showLoader!
          ? runFullLoadingFutuerFunction(
              type: OperationType.CART, function: runfunction)
          : runLoadingFutuerFunction(
              type: OperationType.CART, function: runfunction);
    } else {
      customerCart = null;
      setOderCount = 0;
      Get.forceAppUpdate();
    }
  }
}
