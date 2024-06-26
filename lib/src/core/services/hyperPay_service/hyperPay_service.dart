import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/checkout_controller.dart';

class InAppPaymentSetting {
  // shopperResultUrl : this name must like scheme in intent-filter , url scheme in xcode
  static const String shopperResultUrl = "com.khafif.android";
  static const String merchantId = "MerchantId";
  static const String countryCode = "SA";
  static getLang() {
    if (Platform.isIOS) {
      return "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}

class PaymentService {
  final CheckOutController checkOutController = Get.put(CheckOutController());

  var _paymentResponse;
  var _paymentStatus;
  // String baseUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
  // final String _token =
  //     'OGE4Mjk0MTc0YjdlY2IyODAxNGI5Njk5MjIwMDE1Y2N8c3k2S0pzVDg=';
  String baseUrlTest = 'https://eu-test.oppwa.com';
  String baseUrl = "https://eu-prod.oppwa.com";
  // mada
  String madaEntityId = "8ac9a4cd7203c05401720dbda35a77c3";
  String testMadaEntityId = "8ac7a4c98e42878a018e4c6151bb05a6";

  // visa
  String testVisaEntityId = "8ac7a4ca72029fc0017202eed3c600dc";
  String visaEntityId = "8ac9a4cd7203c05401720db769337728";
  // apple pay
  String applePayEntityID = "8acda4c97a811f85017a84a62be31f89";
  String applePayEntityIDTest = "8ac7a4c78e53939d018e55e5e1c4035c";
  final String _token =
      "OGFjOWE0Y2Q3MjAzYzA1NDAxNzIwZGI3MGE5ODc3MjR8MjJYRVI0U3d0VA==";
  final String _tokenTest =
      "OGFjN2E0Y2E3MjAyOWZjMDAxNzIwMmVlODM0NjAwZDh8UGFSQms5ZlpqZg==";

  String transactionId = "";
  Future<void> getPaymentStatus(
      {required String entity,
      required String trans,
      required int paymentMethod}) async {
    print("**************tttttesttttt*******");
    Uri myUrl =
        Uri.parse('$baseUrl/v1/checkouts/$trans/payment?entityId=$entity');
    print(myUrl);
    final response = await http.get(
      myUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );

    var status = response.body.contains('error');
    var data = json.decode(response.body);

    print(data);

    _paymentResponse = data;
    _paymentStatus = data["result"]["code"];
    if (_paymentStatus.toString() == "000.000.000" ||
        _paymentStatus.toString() == "000.000.100" ||
        _paymentStatus.toString() == "000.100.105" ||
        _paymentStatus.toString() == "000.100.106" ||
        _paymentStatus.toString() == "000.100.110" ||
        _paymentStatus.toString() == "000.100.111" ||
        _paymentStatus.toString() == "000.100.112" ||
        _paymentStatus.toString() == "000.300.000" ||
        _paymentStatus.toString() == "000.300.100" ||
        _paymentStatus.toString() == "000.300.101" ||
        _paymentStatus.toString() == "000.300.102" ||
        _paymentStatus.toString() == "000.300.103" ||
        _paymentStatus.toString() == "000.310.100" ||
        _paymentStatus.toString() == "000.310.101" ||
        _paymentStatus.toString() == "000.310.110" ||
        _paymentStatus.toString() == "000.400.110" ||
        _paymentStatus.toString() == "000.400.120" ||
        _paymentStatus.toString() == "000.600.000" ||
        _paymentStatus.toString() == "000.400.000") {
      // confirmOrder(paymentMethod: paymentMethod);
      checkOutController.confirmOrder(transactionId: transactionId);
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(data["result"]["description"]),
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  void androidReadyUi(
      {required String brandsName,
      required String checkoutId,
      required String entity,
      required int paymentMethod}) async {
    // hideLoadingOverlay();
    BotToast.closeAllLoading();
    print("Android noooooooooooowww");
    print(brandsName);
    print(checkoutId);
    print(entity);
    print(paymentMethod);
    print("Android noooooooooooowww");
    String transactionStatus;
    print(paymentMethod == 0 ? "mada" : brandsName);
    try {
      final String? result =
          await platform.invokeMethod('gethyperpayresponse', {
        "type": "ReadyUI",
        "mode": "LIVE",
        "checkoutid": checkoutId,
        "brand": brandsName, // visa  // mada
      });
      transactionStatus = result ?? 'error';
      getPaymentStatus(
          entity: entity, trans: checkoutId, paymentMethod: paymentMethod);
    } on PlatformException catch (e) {
      transactionStatus = "${e.message}";
    }

    // if (
    //     transactionStatus == "success" ||
    //     transactionStatus == "SYNC") {
    //  /// transactionStatus != null ||
    //  // confirmOrder(paymentMethod: paymentMethod);
    //
    // } else {
    //
    // }
  }

  String resultText = '';
  static const platform = MethodChannel('Hyperpay.demo.fultter/channel');

  FlutterHyperPay? flutterHyperPay = FlutterHyperPay(
    shopperResultUrl:
        InAppPaymentSetting.shopperResultUrl, // return back to app
    paymentMode: PaymentMode.live, // test or live
    lang: InAppPaymentSetting.getLang(),
  );

  payRequestNowReadyUI(
      {required List<String> brandsName,
      required String checkoutId,
      required int paymentMethod,
      required String entity}) async {
    // hideLoadingOverlay();
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay!.readyUICards(
      readyUI: ReadyUI(
          brandsName: brandsName,
          checkoutId: checkoutId,
          merchantIdApplePayIOS: InAppPaymentSetting.merchantId, // applepay
          countryCodeApplePayIOS: InAppPaymentSetting.countryCode, // applePay
          companyNameApplePayIOS: "Khafif", // applePay
          themColorHexIOS: "#000000", // FOR IOS ONLY
          setStorePaymentDetailsMode:
              true // store payment details for future use
          ),
    );
    if (paymentResultData.paymentResult == PaymentResult.sync ||
        paymentResultData.paymentResult == PaymentResult.success) {
      getPaymentStatus(
          paymentMethod: paymentMethod, trans: checkoutId, entity: entity);
    } else if (paymentResultData.paymentResult == PaymentResult.error ||
        paymentResultData.paymentResult == PaymentResult.noResult) {
      Get.defaultDialog(
        title: "Error",
        content: const Text("payment canceled"),
        textConfirm: 'OK',
        onConfirm: () {
          Get.back();
        },
      );
    }
    print(paymentResultData.paymentResult.toString());
    print(paymentResultData.errorString);
  }

  final CartController _cartController = Get.put(CartController());
  int tryingPayment = 1;
  Future<void> checkoutPage({
    required List<String> type,
    required String entityID,
    required int paymentMethod,
  }) async {
    customLoader();
    transactionId = "${_cartController.cart.value!.number!}x$tryingPayment";
    print(transactionId);

    tryingPayment++;
    var status;

    var myUrl = Uri.parse(
        '$baseUrl/v1/checkouts?entityId=$entityID&amount=${(_cartController.cart.value!.amountTotal! + checkOutController.deliverAmount).toString().split('.')[0]}&currency=SAR&merchantTransactionId=$transactionId&paymentType=DB');
    print(myUrl);

    // Uri myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php" as Uri;
    final response = await http.post(
      myUrl,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );

    print("******************************************");
    print(response);
    print("******************************************");

    print(response.body.toString());
    if (response.statusCode == 200) {
      if (Platform.isIOS) {
        payRequestNowReadyUI(
            brandsName: type,
            checkoutId: json.decode(response.body)['id'],
            paymentMethod: paymentMethod,
            entity: entityID);
      } else {
        androidReadyUi(
            brandsName: type[0],
            checkoutId: json.decode(response.body)['id'],
            entity: entityID,
            paymentMethod: paymentMethod);
      }
    }
  }
}
