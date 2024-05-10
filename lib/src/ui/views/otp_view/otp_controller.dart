// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

class OtpController extends GetxController {
  @override
  void onReady() {
    countdownController.start();
    super.onReady();
  }

  @override
  void onClose() {
    // textEditingController.dispose();
    SmsAutoFill().unregisterListener();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    print(SmsAutoFill().getAppSignature);
    await SmsAutoFill().listenForCode();
    super.onInit();
  }

  RxInt current = 0.obs;
  RxString otpCode = "".obs;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String verID = "";
  CountdownController countdownController = CountdownController();
  RxInt timeout = 20.obs;

  goToStep1() {
    current.value = 0;
  }

  goToStep2() {
    current.value = 1;
  }

  goToStep3() {
    current.value = 2;
  }

  Future<void> verifyPhone(String phone) async {
    await UserRepository()
        .verifyUser(userOtp: otpCode.value, phone: phone)
        .then((value) => value.fold((l) {
              CustomToast.showMessage(
                  message: l.isNotEmpty ? l : tr('invalid_code_lb'),
                  messageType: MessageType.REJECTED);
              storage.setOtpVerified(false);
            }, (r) {
              storage.setUserInfo(r);
              storage.setOtpVerified(true);

              CustomToast.showMessage(
                  message: tr("done_btn_lb"), messageType: MessageType.SUCCESS);
              Future.delayed(
                  Duration(seconds: 2), () => Get.offAll(ProductsView()));
            }));
  }
}
