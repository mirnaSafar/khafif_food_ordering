
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_popup_with_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/my_information_controller.dart';

void showImagePickerDialog(BuildContext context) {
  MyInfoController infoController = Get.put(MyInfoController());
  Future<FileTypeModel> pickFile(FileTypeEnum type) async {
    switch (type) {
      case FileTypeEnum.GALLERY:
        await infoController.picker
            .pickImage(source: ImageSource.gallery)
            .then((value) => infoController.path.value = value?.path ?? '');

        // splitPath = path!.split("/").last;
        // postImageType = splitPath!.split(".").last;
        // imageFile = File(path!);

        // List<int> imageBytes = await imageFile!.readAsBytes();

        // imageBase64 = base64Encode(imageBytes);

        context.pop();

        //

        break;
      case FileTypeEnum.CAMERA:
        await infoController.picker
            .pickImage(source: ImageSource.camera)
            .then((value) => infoController.path.value = value?.path ?? '');

        // imageFile = File(path!);
        // splitPath = path!.split("/").last;
        // postImageType = splitPath!.split(".").last;

        // List<int> imageBytes = await imageFile!.readAsBytes();

        // imageBase64 = base64Encode(imageBytes);

        context.pop();

        break;
      case FileTypeEnum.FILE:
      // TODO: Handle this case.
    }
    infoController.selectedFile.value =
        FileTypeModel(infoController.path.value, type);
    return infoController.selectedFile.value;
  }

  showModalBottomSheet(
    elevation: 0,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Obx(() {
        print(infoController.path.value);
        return CustomPopupWithBlurWidget(
            customBlurChildType: CustomBlurChildType.BOTTOMSHEET,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.mainWhiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              padding: EdgeInsets.all(screenWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      pickFile(FileTypeEnum.CAMERA);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        screenWidth(20).px,
                        const CustomText(
                          textType: TextStyleType.BODYSMALL,
                          text: 'Camera',
                        )
                      ],
                    ),
                  ),
                  screenWidth(20).ph,
                  CustomButton(
                    onPressed: () {
                      pickFile(FileTypeEnum.GALLERY).then(
                          (value) => infoController.selectedFile.value = value);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.image,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        screenWidth(20).px,
                        const CustomText(
                          textType: TextStyleType.BODYSMALL,
                          text: 'Gallery',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      });
    },
  );
}
