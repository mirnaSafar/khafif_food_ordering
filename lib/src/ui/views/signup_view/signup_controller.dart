import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';

import '../../../core/app/app_config/app_config.dart';

class SignUpController extends BaseController {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController(text: '');

  TextEditingController nameController = TextEditingController();

  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void signup() {
    isLoading.value = true;
    formKey.currentState!.validate()
        ?
        // : null;

        runFullLoadingFutuerFunction(
            function: UserRepository()
                .signup(
            email: emailController.text,
            userName: nameController.text,
            phone: '${AppConfig.countryCode}${phoneController.text}',
          )
                .then((value) {
            print(value);
            value.fold((l) {
              isLoading.value = false;

              CustomToast.showMessage(
                  message: l, messageType: MessageType.REJECTED);
            }, (r) {
              CustomToast.showMessage(
                  message: 'registered successfully!',
                  messageType: MessageType.SUCCESS);
              Get.off(() => LoginView());
            });
          }))
        : null;
  }
}
