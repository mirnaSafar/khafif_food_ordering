import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/sign_verification/sign_verification_view.dart';

class LoginController extends BaseController {
  RxBool isLoading = false.obs;
  TextEditingController phoneController =
      TextEditingController(text: !kReleaseMode ? "+963936166750" : "");
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'login');

  void login() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      runFullLoadingFutuerFunction(
          function:
              UserRepository().login(phone: phoneController.text).then((value) {
        value.fold((l) {
          isLoading.value = false;

          CustomToast.showMessage(
              messageType: MessageType.REJECTED, message: l);
          isLoading.value = false;
        }, (r) {
          isLoading.value = false;
          storage.setTokenIno(r.token ?? '');
          storage.setOtpTime(r.timeOtpMinutes.toString());

          //SharedPrefrenceRepository.setLoggedIn(true);
          Get.to(SignVerification(number: phoneController.text));
        });
      }));
    }
  }
}
