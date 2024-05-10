import 'dart:io';

import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/services/hyperPay_service/hyperPay_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/payment_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/order_repository.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/payment_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/tracking_order_view/tracking_order_view.dart';

class CheckOutController extends BaseController {
  @override
  void onInit() {
    getPaymentMethods();
    super.onInit();
  }

  RxBool viewMore = true.obs;
  SplashController splashController = Get.put(SplashController());
  double get deliverAmount => slectedDeliveryService()?.fixedPrice! ?? 0.0;

  CustomerCartModel emptyCart = CustomerCartModel(
    line: [],
    amountTotal: 0.0,
  );
  CartController cartController = Get.put(CartController());
  RxList<PaymentModel> paymentMethods = <PaymentModel>[].obs;
  RxBool get isPaymentsLoading =>
      operationType.contains(OperationType.CART).obs;
  RxInt selectedItem = 0.obs;

  List<List<String>> PaymentMethodsInfo = [
    ['MADA', "8ac9a4cd7203c05401720dbda35a77c3"],
    ['VISA', "8ac9a4cd7203c05401720db769337728"],
    ['APPLEPAY', "8acda4c97a811f85017a84a62be31f89"],
  ];
  List<String> PaymentMethodsImages = [
    AppAssets.icMadaCart,
    AppAssets.icVisa,
    if (Platform.isIOS) AppAssets.icApplePay,
    AppAssets.icDelivery,
  ];

  void checkout() {
    filteredPaymentModelList[selectedItem.value].mobileCode == '3'
        ? confirmOrder()
        : PaymentService().checkoutPage(
            type: [
              PaymentMethodsInfo[
                  int.parse(paymentMethods[selectedItem.value].mobileCode!)][0]
            ],
            entityID: PaymentMethodsInfo[
                int.parse(paymentMethods[selectedItem.value].mobileCode!)][1],
            paymentMethod:
                int.parse(paymentMethods[selectedItem.value].mobileCode!),
          );
  }

  void confirmOrder({String? transactionId}) {
    runFullLoadingFutuerFunction(
        function: OrdersRepository()
            .closeOrder(
                transactionId: transactionId,
                paymentMethod: int.parse(
                    filteredPaymentModelList[selectedItem.value].mobileCode!),
                shippingMethod:
                    productsVieewController.orderOptionSelected.value - 1,
                amount:
                    cartController.customerCart!.value.amountTotal!.toString())
            .then((value) => value.fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
                  CustomToast.showMessage(
                      message: tr("order_placed_lb"),
                      messageType: MessageType.SUCCESS);

                  cartController.setOderCount = 0;
                  storage.setOrderDeliveryOptionSelected(0);
                  productsVieewController.setDelieryServiceAddressOrBranch(
                      address: '');
                  storage.setNewOrder(true);
                  storage.setCart(emptyCart);
                  // cartController.cart.value = emptyCart;
                  cartService.clearCart();
                  cartService.cartList.value = [];
                  cartService.calcCartCount(cart: r);
                  cartController.setOderCount =
                      cartService.cartCustomerCount.value;
                  // myOrderController.getMyOrders();
                  cartController.selectedCart.value = Line();
                  Get.off(TrackingOrderView(
                    cartModel: cartController.cart.value!,
                  ));
                  cartService.cart.value = null; // Navigator.of(globalContext)
                  //     .popUntil((route) => route.isFirst);
                  //                                   Get.offUntil(
                  // GetPageRoute(page: () =>  TrackingOrderView()),
                  // ModalRoute.withName('/'));
                })));
  }

  RxList<PaymentModel> filteredPaymentModelList = <PaymentModel>[].obs;
  String excludedId = '2';
  void getPaymentMethods() {
    runLoadingFutuerFunction(
        type: OperationType.CART,
        function: PaymentRepository().getPaymentMethods().then((value) => value
                .fold(
                    (l) => CustomToast.showMessage(
                        message: l, messageType: MessageType.WARNING), (r) {
              paymentMethods.addAll(r);
              paymentMethods.sort((a, b) =>
                  int.parse(a.mobileCode!).compareTo(int.parse(b.mobileCode!)));
              // paymentMethods.value = paymentMethods
              //     .skipWhile((element) => element.mobileCode == '2')
              //     .toList();
              for (PaymentModel paymentModel in paymentMethods) {
                if (Platform.isAndroid) {
                  if (paymentModel.mobileCode != excludedId) {
                    filteredPaymentModelList.add(paymentModel);
                  }
                } else {
                  filteredPaymentModelList.add(paymentModel);
                }
              }
            })));
  }
}
