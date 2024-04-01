import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';

class MyInfoController extends BaseController {
  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<ProfileController>();
    Get.put(ProfileController());

    super.onClose();
  }

  submitInfo() {
    formkey.currentState!.validate()
        ? runLoadingFutuerFunction(
            type: OperationType.MODIFYUSERINFORMATION,
            function: UserRepository()
                .modifyUserInfo(
              image: path.value,
              userName: userNameController.text,
              email: userEmailController.text,
              // phone: userNumberController.text,
            )
                .then((value) {
              value.fold(
                  (l) => CustomToast.showMessage(
                      message: l, messageType: MessageType.REJECTED), (r) {
                storage.setUserInfo(r);
                CustomToast.showMessage(
                    message: 'Info Changed Successfully  ',
                    messageType: MessageType.SUCCESS);
                // storage.getUserInfo();
                // userinfo?.value = r;
                Get.forceAppUpdate();

                Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    Get.back(result: r);
                    // Get.back(result: r);
                    // Get.to(const ProfileView());
                  },
                );
              });
            }))
        : null;
  }

  TextEditingController userNameController =
      TextEditingController(text: userinfo?.value!.name ?? '');
  TextEditingController userNumberController =
      TextEditingController(text: userinfo?.value!.phone ?? '');
  TextEditingController userEmailController =
      TextEditingController(text: userinfo?.value!.email ?? '');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool get submitChangesLoading =>
      operationType.contains(OperationType.MODIFYUSERINFORMATION).obs;

  final ImagePicker picker = ImagePicker();
  Rx<FileTypeModel> selectedFile = FileTypeModel('', FileTypeEnum.FILE).obs;
  RxString path = ''.obs;
  Rx<File>? imageFile;
  String? imageBase64;
  String? splitPath;
  String? postImageType;
}
