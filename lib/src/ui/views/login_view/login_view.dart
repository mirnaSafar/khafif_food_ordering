// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = Get.put(LoginController());

  String countryCode = "+966";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth(30),
          ),
          child: SingleChildScrollView(
              child: Form(
            key: controller.formKey,
            child: FutureBuilder(
                future: whenNotZero(
                  Stream<double>.periodic(Duration(milliseconds: 50),
                      (x) => MediaQuery.of(context).size.width),
                ),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data! > 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.screenWidth(1.7).ph,
                          CustomText(
                            text: tr("login_lb"),
                            textType: TextStyleType.HEADER,
                            fontWeight: FontWeight.bold,
                          ),
                          context.screenWidth(40).ph,
                          CustomText(
                            text: tr("login_title_lb"),
                            textType: TextStyleType.SUBTITLE,
                            // fontSize: 18,
                          ),
                          context.screenWidth(10).ph,
                          UserInput(
                            maxLength: 9,
                            keyboardType: TextInputType.phone,
                            validator: (number) {
                              return null;
//
                              // return numberValidator(number!);
                            },
                            controller: controller.phoneController,
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
                          context.screenWidth(10).ph,
                          CustomButton(
                            key: Key('login'),
                            onPressed: () {
                              controller.login();
                            },
                            text: tr("login_lb"),
                          ),
                          context.screenWidth(6).ph,
                          // Center(
                          //   child: CustomText(
                          //       text: tr("or_lb"),
                          //       customtextStyle:
                          //           Theme.of(context).textTheme.bodyLarge!,
                          //       fontWeight: FontWeight.bold,
                          //       textType: TextStyleType.BODY),
                          // ),
                          // context.screenWidth(10).ph,
                          // CustomButton(
                          //   key: Key('google1'),
                          //   onPressed: () => onTapLoginWithGoogle(),
                          //   text: tr("google_lb"),
                          //   color: Colors.white,
                          //   textStyleType: TextStyleType.BODYSMALL,
                          //   imageName: 'google_ic',
                          // ),
                          context.screenWidth(3).ph,
                          CustomRowText(
                              onTap: () => Get.off(SignUpView()),
                              firstText: tr('not_signup_lb'),
                              linkText: tr('signup_lb')),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }),
          )),
        ));
  }
}
