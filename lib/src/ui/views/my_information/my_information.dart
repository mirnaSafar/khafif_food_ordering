import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_user_card.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/my_information_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/widgets/image_picker_dialog.dart';

class MyInformationView extends StatefulWidget {
  const MyInformationView({super.key});

  @override
  State<MyInformationView> createState() => _MyInformationViewState();
}

class _MyInformationViewState extends State<MyInformationView> {
  MyInfoController infoController = Get.put(MyInfoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(appbarTitle: tr('info_lb')),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth(15.0)),
              child: Obx(
                () => Form(
                  key: infoController.formkey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.mainWhiteColor,
                            radius: screenWidth(6.7),
                            child: CircleAvatar(
                              radius: screenWidth(7),
                              backgroundColor: AppColors.mainWhiteColor,
                              backgroundImage: infoController
                                      .selectedFile.value.path.isNotEmpty
                                  ? FileImage(
                                      File(infoController
                                          .selectedFile.value.path),
                                    )
                                  : NetworkImage(
                                      userinfo?.value!.image ?? '',
                                    ) as ImageProvider,
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            end: 0,
                            child: InkWell(
                              onTap: () {
                                showImagePickerDialog(context);
                              },
                              child: CircleAvatar(
                                radius: screenWidth(30),
                                backgroundColor: AppColors.mainWhiteColor,
                                child: CircleAvatar(
                                    radius: screenWidth(40),
                                    backgroundColor: AppColors.mainAppColor,
                                    child: Icon(
                                      Icons.edit,
                                      size: screenWidth(30),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                      screenWidth(10).ph,
                      UserInput(
                        validator: (value) => nameValidator(value),
                        controller: infoController.userNameController,
                        text: tr('name_field_lb'),
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(AppAssets.icUser),
                        ),
                      ),
                      screenWidth(30).ph,
                      UserInput(
                        validator: (value) => emailValidator(value),
                        controller: infoController.userEmailController,
                        text: tr('email_field_lb'),
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(AppAssets.icEmail),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            screenWidth(40).ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
              child: const CustomUserCard(),
            ),
            screenWidth(40).ph,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(15), vertical: screenWidth(20)),
              child: CustomButton(
                loader: infoController.submitChangesLoading.value,
                onPressed: () {
                  infoController.submitInfo();
                },
                text: tr('submit_lb'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
