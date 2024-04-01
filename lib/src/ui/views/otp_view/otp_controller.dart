import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
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

  // verifyPhone(String number) async {
// PhoneAuthOptions options =
//   PhoneAuthOptions.newBuilder(mAuth)
//       .setPhoneNumber(phoneNumber)       // Phone number to verify
//       .setTimeout(60L, TimeUnit.SECONDS) // Timeout and unit
//       .setActivity(this)                 // (optional) Activity for callback binding
//       // If no activity is passed, reCAPTCHA verification can not be used.
//       .setCallbacks(mCallbacks)          // OnVerificationStateChangedCallbacks
//       .build();
//   PhoneAuthProvider.verifyPhoneNumber(options);

  // await FirebaseAuth.instance.verifyPhoneNumber(
  //   phoneNumber: number,
  //   timeout: Duration(seconds: timeout.value),
  //   verificationCompleted: (PhoneAuthCredential credential) {
  //     showSnackbarText('Auth Completed!');
  //   },
  //   verificationFailed: (FirebaseException e) {
  //     print(e);
  //     showSnackbarText('Auth Failed!');
  //   },
  //   codeSent: (verificationId, forceResendingToken) {
  //     showSnackbarText('OTP Sent!');
  //     verID = verificationId;
  //   },
  //   codeAutoRetrievalTimeout: (verificationId) {
  //     showSnackbarText('Timeout!');
  //   },
  // );
  // }

  goToStep1() {
    current.value = 0;
  }

  goToStep2() {
    current.value = 1;
  }

  goToStep3() {
    current.value = 2;
  }

  // Future<void> codeVerificationProcess() async {
  //   await FirebaseAuth.instance
  //       .signInWithCredential(
  //     PhoneAuthProvider.credential(
  //         verificationId: verID, smsCode: otpCode.value),
  //   )
  //       .whenComplete(() {
  //     CustomToast.showMessage(
  //         message: 'done', messageType: MessageType.SUCCESS);
  //     Get.off(const ProductsView());
  //   }).catchError(CustomToast.showMessage(
  //           message: 'invalid code', messageType: MessageType.REJECTED));
  // }

  Future<void> verifyPhone(String phone) async {
    await UserRepository()
        .verifyUser(userOtp: otpCode.value, phone: phone)
        .then((value) => value.fold((l) {
              CustomToast.showMessage(
                  message: l.isNotEmpty ? l : 'invalid code',
                  messageType: MessageType.REJECTED);
            }, (r) {
              storage.setUserInfo(r);
              storage.setOtpVerified(true);

              CustomToast.showMessage(
                  message: 'done', messageType: MessageType.SUCCESS);
              Future.delayed(const Duration(seconds: 2),
                  () => Get.offAll(const ProductsView()));
            }));
  }
}
