// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/domain/googleauth/google_auth_helper.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_row_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/signup_view/signup_controller.dart';

import '../../../core/app/app_config/app_config.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:  CustomAppbar(),
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.screenWidth(30),
      ),
      child: Form(
        key: controller.formKey,
        child: FutureBuilder(
            future: whenNotZero(
              Stream<double>.periodic(const Duration(milliseconds: 50),
                  (x) => MediaQuery.of(context).size.width),
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data! > 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.screenWidth(3).ph,
                      CustomText(
                        text: tr("signup_lb"),
                        textType: TextStyleType.HEADER,
                        fontWeight: FontWeight.bold,
                      ),
                      context.screenWidth(40).ph,
                      CustomText(
                          text: tr("signup_title_lb"),
                          textType: TextStyleType.SUBTITLE),
                      context.screenWidth(20).ph,
                      UserInput(
                        controller: controller.nameController,
                        text: tr("name_field_lb"),
                        fillColor: Get.theme.colorScheme.primary,
                        prefixIcon: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset(
                                color: Get.theme.colorScheme.secondary,
                                AppAssets.icUser)),
                      ),
                      context.screenWidth(20).ph,
                      UserInput(
                        maxLength: 10,
                        // prefixText:,
                        fillColor: Get.theme.colorScheme.primary,
                        keyboardType: TextInputType.phone,
                        validator: (number) {
                          // return null;

                          return numberValidator(number!);
                        },
                        controller: controller.phoneController,
                        text: tr('phone_field_lb'),
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                              color: Get.theme.colorScheme.secondary,
                              AppAssets.icPhone),
                        ),
                      ),
                      context.screenWidth(20).ph,
                      UserInput(
                        controller: controller.emailController,
                        text: tr("email_field_lb"),
                        fillColor: Get.theme.colorScheme.primary,
                        prefixIcon: Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                              color: Get.theme.colorScheme.secondary,
                              AppAssets.icEmail),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          return emailValidator(email);
                        },
                      ),
                      context.screenWidth(20).ph,
                      CustomButton(
                        key: const Key('signup'),
                        text: tr("signup_lb"),
                        onPressed: () {
                          controller.signup();
                        }, // color: Theme.of(context).primaryColor,
                      ),
                      // context.screenWidth(8).ph,
                      // Center(
                      //   child: CustomText(
                      //       customtextStyle:
                      //           Theme.of(context).textTheme.bodyLarge!,
                      //       text: tr("or_lb"),
                      //       fontWeight: FontWeight.bold,
                      //       textType: TextStyleType.BODY),
                      // ),
                      // context.screenWidth(60).ph,
                      // CustomButton(
                      //   key: const Key('google2'),
                      //   onPressed: () => onTapLoginWithGoogle(),
                      //   text: tr("google_lb"),
                      //   color: Colors.white,
                      //   imageName: 'google_ic',
                      // ),
                      context.screenWidth(8).ph,
                      CustomRowText(
                        key: const Key('sign log in'),
                        onTap: () => Get.off(LoginView(
                          key: const Key('1'),
                        )),
                        firstText: tr('joined_us_lb'),
                        linkText: tr("login_lb"),
                      ),
                      context.screenHeight(30).ph,
                      CustomRowText(
                          onTap: () => Get.offAll(ProductsView()),
                          textStyleType: TextStyleType.BODYSMALL,
                          firstColor: AppColors.mainGreyColor,
                          // fontsize: 16,

                          firstText: tr('guest_lb'),
                          linkText: tr('guest_view_lb')),
                      context.screenHeight(30).ph,
                    ],
                  );
                }
              }
              return Container();
            }),
      ),
    )));
  }
}
