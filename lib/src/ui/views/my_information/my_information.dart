// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_user_card.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/my_information_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/widgets/image_picker_dialog.dart';

class MyInformationView extends StatefulWidget {
  MyInformationView({super.key});

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
                padding: EdgeInsets.all(context.screenWidth(15.0)),
                child: Obx(
                  () => Form(
                    key: infoController.formkey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.mainWhiteColor,
                              radius: context.screenWidth(6.7),
                              child: CircleAvatar(
                                radius: context.screenWidth(7),
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
                                  radius: context.screenWidth(30),
                                  backgroundColor: AppColors.mainWhiteColor,
                                  child: CircleAvatar(
                                      radius: context.screenWidth(40),
                                      backgroundColor: AppColors.mainAppColor,
                                      child: Icon(
                                        Icons.edit,
                                        size: context.screenWidth(30),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        context.screenWidth(10).ph,
                        UserInput(
                          validator: (value) => nameValidator(value),
                          controller: infoController.userNameController,
                          text: tr('name_field_lb'),
                          prefixIcon: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(AppAssets.icUser),
                          ),
                        ),
                        context.screenWidth(30).ph,
                        UserInput(
                          validator: (value) => emailValidator(value),
                          controller: infoController.userEmailController,
                          text: tr('email_field_lb'),
                          prefixIcon: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(AppAssets.icEmail),
                          ),
                        ),
                        context.screenWidth(30).ph,
                        UserInput(
                          maxLength: kDebugMode ? null : 9,
                          keyboardType: TextInputType.phone,
                          validator: (number) {
                            return kDebugMode ? null : numberValidator(number!);
                          },
                          controller: infoController.userNumberController,
                          text: tr('phone_field_lb'),
                          prefixIcon: SizedBox(
                            width: context.screenWidth(4.1),
                            child: Row(
                              children: <Widget>[
                                context.screenWidth(30).px,
                                SvgPicture.asset(AppAssets.icPhone),
                                context.screenWidth(30).px,
                                CustomText(
                                  text: '+966 | ',
                                  textType: TextStyleType.BODYSMALL,
                                  darkTextColor: AppColors.mainTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              context.screenWidth(40).ph,
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.screenWidth(40)),
                child: CustomUserCard(),
              ),
              context.screenWidth(40).ph,
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth(15),
                      vertical: context.screenWidth(20)),
                  child: CustomButton(
                    loader: infoController.submitChangesLoading.value,
                    onPressed: () {
                      infoController.submitInfo();
                    },
                    text: tr('submit_lb'),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
