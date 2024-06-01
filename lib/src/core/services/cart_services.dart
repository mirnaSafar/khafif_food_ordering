import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';

class CartService {
  RxList<CartModel> cartList = storage.getCartList().obs;
  Rx<CustomerCartModel?> cart = storage.getCart().obs;
  RxInt cartCustomerCount = 0.obs;

  RxInt cartCount = 0.obs;
  RxInt productsCount = 0.obs;

  RxDouble subTotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble deliverFees = 0.0.obs;
  RxDouble total = 0.0.obs;

  CartService() {
    getCartCount();
    // getMealCount();
    calcCartTotal();
  }
  void addToCart({
    required ProductTemplateModel model,
    required int count,
    Function? afterAdd,
  }) {
    double mealTotal = calcMealTotal(count: count, model: model);
    if (getCartModel(model) != null) {
      int index = getIndex(getCartModel(model)!);
      cartList[index].count = cartList[index].count! + count;
      productsCount.value = cartList[index].count!;
      cartList[index].total = cartList[index].total! + mealTotal;
    } else {
      cartList.add(CartModel(count: count, total: mealTotal, product: model));
    }
    storage.setCartList(cartList);
    cartCount.value += count;
    if (afterAdd != null) afterAdd();

    calcCartTotal();
  }

  calcCartCount({required CustomerCartModel cart}) {
    cartCustomerCount.value = 0;

    cartCount.value = 0;
    if (cart.line != null) {
      for (var line in cart.line!) {
        cartCustomerCount.value += line.productUomQty!.toInt();
        cartCount.value += line.productUomQty!.toInt();
      }
    }
  }

  void removeFromCartList(CartModel model) {
    cartList.removeWhere(
      (element) => element.product!.id == model.product!.id,
    );
    cartCount.value -= model.count!;

    storage.setCartList(cartList);

    calcCartTotal();
  }

  void changeCount(
      {required bool incress,
      required CartModel model,
      Function? afterChange}) {
    CartModel? result = getCartModel(model.product!);

    int index = getIndex(result!);

    if (incress) {
      result.count = result.count! + 1;
      result.total = result.total! + model.product!.price!.toDouble();
      cartCount.value += 1;
      calcCartTotal();
    } else {
      if (result.count! > 1) {
        result.count = result.count! - 1;
        result.total = result.total! - model.product!.price!.toDouble();
        cartCount.value -= 1;
        calcCartTotal();
      }
    }

    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
    if (afterChange != null) afterChange();
  }

  void clearCart() {
    cartList.clear();
    cartCount.value = getCartCount();
    cartCustomerCount.value = 0;
    calcCartTotal();
    calcCartCount(cart: cart.value!);
    storage.setCartList(cartList);
  }

  double calcMealTotal(
      {required ProductTemplateModel model, required int count}) {
    return (model.price! * count).toDouble();
  }

  CartModel? getCartModel(ProductTemplateModel model) {
    return cartList.firstWhereOrNull(
      (element) =>
          element.product!.id == model.id &&
          element.product!.name == model.name,
    );
  }

  int getCartCount() {
    cartCount.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.count!);

    return cartCount.value;
  }

  // int getMealCount(ProductTemplateModel model) {
  //   getCartModel(model) != null
  //       ? productsCount.value = getCartModel(model)!.count!
  //       : productsCount.value = 0;

  //   return productsCount.value;
  // }

  int getIndex(CartModel model) => cartList.indexOf(model);

  void calcCartTotal() {
    subTotal.value = 0.0;
    tax.value = 0.0;
    deliverFees.value = 0.0;
    total.value = 0.0;

    subTotal.value = cartList.fold(
        0, (previousValue, element) => previousValue + element.total!);
    tax.value += subTotal.value * taxAmount;
    deliverFees.value += (subTotal.value + tax.value) * 0.15;
    total.value = subTotal.value + deliverFees.value + tax.value;
  }
}

  // Map<String, double> calcTotals() {
  //   var totals = cartList.map((element) => element.total);

  //   double subTotal =
  //       totals.fold(0.0, (previousValue, element) => previousValue + element!); 
  //   double totalTax = subTotal * taxAmount;
  //   double deliveryFee = (totalTax + subTotal) * deliveryFeedAmount;
  //   double totalSum = subTotal + totalTax + deliveryFee;
  //   // // invoice.insertAll(0,);
  //   return {
  //     'subTotal': subTotal,
  //     "totalTax": totalTax,
  //     'deliveryFee': deliveryFee,
  //     'totalSum': totalSum
  //   };
  // }