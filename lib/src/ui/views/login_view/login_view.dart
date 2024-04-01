import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/domain/googleauth/google_auth_helper.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_row_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = Get.put(LoginController());

  String countryCode = "+966";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(30),
              ),
              child: SingleChildScrollView(
                  child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenWidth(2.5).ph,
                    CustomText(
                      text: tr("login_lb"),
                      textType: TextStyleType.HEADER,
                      fontWeight: FontWeight.bold,
                    ),
                    screenWidth(40).ph,
                    CustomText(
                      text: tr("login_title_lb"),
                      textType: TextStyleType.SUBTITLE,
                      // fontSize: 18,
                    ),
                    screenWidth(10).ph,
                    UserInput(
                      // maxLength: 9,
                      keyboardType: TextInputType.phone,
                      validator: (number) {
                        return null;

                        // return numberValidator(number!);
                      },
                      controller: controller.phoneController,
                      text: tr('phone_field_lb'),
                      prefixIcon: SizedBox(
                        width: screenWidth(4.1),
                        child: Row(
                          children: <Widget>[
                            screenWidth(30).px,
                            SvgPicture.asset(AppAssets.icPhone),
                            screenWidth(30).px,
                            CustomText(
                              text: '+966 | ',
                              textType: TextStyleType.BODYSMALL,
                              darkTextColor: AppColors.mainTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    screenWidth(10).ph,
                    CustomButton(
                      key: const Key('login'),
                      onPressed: () {
                        controller.login();
                      },
                      text: tr("login_lb"),
                    ),
                    screenWidth(6).ph,
                    Center(
                      child: CustomText(
                          text: tr("or_lb"),
                          customtextStyle:
                              Theme.of(context).textTheme.bodyLarge!,
                          fontWeight: FontWeight.bold,
                          textType: TextStyleType.BODY),
                    ),
                    screenWidth(10).ph,
                    CustomButton(
                      key: const Key('google1'),
                      onPressed: () => onTapLoginWithGoogle(),
                      text: tr("google_lb"),
                      color: Colors.white,
                      textStyleType: TextStyleType.BODYSMALL,
                      imageName: 'google_ic',
                    ),
                    screenWidth(5).ph,
                    CustomRowText(
                        onTap: () => Get.off(const SignUpView()),
                        firstText: tr('not_signup_lb'),
                        linkText: tr('signup_lb')),
                  ],
                ),
              )),
            )));
  }
}
