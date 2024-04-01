import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/signup_view/signup_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: const CustomAppbar(),
            body: SingleChildScrollView(
                child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(30),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            screenWidth(5).ph,
            CustomText(
              text: tr("signup_lb"),
              textType: TextStyleType.HEADER,
              fontWeight: FontWeight.bold,
            ),
            screenWidth(40).ph,
            CustomText(
                text: tr("signup_title_lb"), textType: TextStyleType.SUBTITLE),
            screenWidth(20).ph,
            UserInput(
              controller: controller.nameController,
              text: tr("name_field_lb"),
              prefixIcon: Transform.scale(
                  scale: 0.5, child: SvgPicture.asset(AppAssets.icUser)),
            ),
            screenWidth(20).ph,
            UserInput(
              // maxLength: 9,
              // prefixText:,
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
            screenWidth(20).ph,
            UserInput(
              controller: controller.emailController,
              text: tr("email_field_lb"),
              prefixIcon: Transform.scale(
                scale: 0.5,
                child: SvgPicture.asset(AppAssets.icEmail),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                return emailValidator(email);
              },
            ),
            screenWidth(20).ph,
            CustomButton(
              key: const Key('signup'),
              text: tr("signup_lb"),
              onPressed: () {
                controller.signup();
              }, // color: Theme.of(context).primaryColor,
            ),
            screenWidth(20).ph,
            Center(
              child: CustomText(
                  customtextStyle: Theme.of(context).textTheme.bodyLarge!,
                  text: tr("or_lb"),
                  fontWeight: FontWeight.bold,
                  textType: TextStyleType.BODY),
            ),
            screenWidth(20).ph,
            CustomButton(
              key: const Key('google2'),
              onPressed: () => onTapLoginWithGoogle(),
              text: tr("google_lb"),
              color: Colors.white,
              imageName: 'google_ic',
            ),
            screenWidth(5).ph,
            CustomRowText(
              key: const Key('sign log in'),
              onTap: () => Get.off(const LoginView(
                key: Key('1'),
              )),
              firstText: tr('joined_us_lb'),
              linkText: tr("login_lb"),
            ),
            screenHeight(30).ph,
            CustomRowText(
                onTap: () => Get.offAll(const ProductsView()),

                // textStyleType: TextStyleType.BODYSMALL,
                firstColor: AppColors.mainGreyColor,
                fontsize: 16,
                firstText: 'Don\'t want to create an account ?   ',
                linkText: 'Guest view'),
            screenHeight(30).ph,
          ],
        ),
      ),
    ))));
  }
}
