// import 'package:khafif_food_ordering_application/core/enums/message_type.dart';
// import 'package:khafif_food_ordering_application/core/services/base_controller.dart';
// import 'package:khafif_food_ordering_application/ui/shared/custom_widgets/custom_toast.dart';
// import 'package:khafif_food_ordering_application/ui/shared/utils.dart';
// import 'package:khafif_food_ordering_application/ui/views/checkout_view/checkout_view.dart';

// import 'package:get/get.dart';

// import '../../../data/models/apis/cart_model.dart';

// class CartController extends BaseController {
//   List<CartModel> get cartList => cartService.cartList;

//   void removeFromCart(CartModel model) {
//     cartService.removeFromCartList(model);
//   }

//   // void changeCount({required bool incress, required CartModel model}) {
//   //   cartService.changeCount(incress: incress, model: model);
//   // }

//   void checkout() {
//     runFullLoadingFutuerFunction(
//         function: Future.delayed(const Duration(seconds: 2)).then((value) {
//       CustomToast.showMessage(
//           message: 'Order placed successfully',
//           messageType: MessageType.SUCCESS);

//       Get.off(const CheckoutView());
//     }));
//   }

// //!---- First -----

//   // RxDouble subTotal = 0.0.obs;
//   // RxDouble tax = 0.0.obs;
//   // RxDouble deliverFees = 0.0.obs;
//   // RxDouble total = 0.0.obs;

//   // void calcCartTotal() {
//   //   subTotal.value = 0.0;
//   //   cartList.forEach((element) {
//   //     subTotal.value += element.total ?? 0.0;
//   //   });
//   //   tax.value += subTotal.value * taxAmount;
//   //   deliverFees.value += (subTotal.value + tax.value) * deliverAmount;
//   //   total.value = subTotal.value + deliverFees.value + tax.value;
//   // }

//   // //!--- Seconde -----
//   // double calcSubTotal() {
//   //   double total = 0.0;
//   //   cartList.forEach((element) {
//   //     total += element.total ?? 0.0;
//   //   });
//   //   return total;
//   // }

//   // double calcTax() {
//   //   return calcSubTotal() * taxAmount;
//   // }

//   // double calcDeliveryFees() {
//   //   return (calcSubTotal() + calcTax()) * deliverAmount;
//   // }

//   // double calcTotal() {
//   //   return calcSubTotal() + calcTax() + calcDeliveryFees();
//   // }

//   //!--- Third ----
//   // Map<String, double> calcTotals() {
//   //   double subTotal = 0.0;
//   //   double tax = 0.0;
//   //   double deliverFees = 0.0;
//   //   double total = 0.0;

//   //   cartList.forEach((element) {
//   //     subTotal += element.total ?? 0.0;
//   //   });
//   //   tax += subTotal * taxAmount;
//   //   deliverFees += (subTotal + tax) * deliverAmount;
//   //   total = subTotal + deliverFees + tax;

//   //   return {
//   //     "subTotal": subTotal,
//   //     "tax": tax,
//   //     "deliverFees": deliverFees,
//   //     "total": total
//   //   };
//   // }
// }
