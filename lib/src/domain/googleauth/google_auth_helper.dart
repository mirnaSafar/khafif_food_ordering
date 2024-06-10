// ignore_for_file: prefer_const_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_controller.dart';

RxString userGoogleEmail = ''.obs;
RxString userGoogleName = ''.obs;

class GoogleAuthHelper {
  GoogleAuthHelper();

  /// Handle Google Signin to authenticate user
  Future<GoogleSignInAccount?> googleSignInProcess() async {
    customLoader();
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      userGoogleEmail.value = googleUser.email;
      userGoogleName.value = googleUser.displayName ?? '';
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );

      return googleUser;
    }
    return null;
  }

  /// To Check if the user is already signedin through google
  Future<bool> alreadySignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    bool alreadySignIn = await googleSignIn.isSignedIn();
    return alreadySignIn;
  }

  /// To signout from the application if the user is signed in through google
  Future<GoogleSignInAccount?> googleSignOutProcess() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signOut();

    return googleUser;
  }
}

onTapLoginWithGoogle() async {
  if (await GoogleAuthHelper().alreadySignIn()) {
    await GoogleAuthHelper().googleSignOutProcess();
  }
  await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
    if (googleUser != null) {
      // CustomToast.showMessage(
      //     message: 'Signed in Successfully!', messageType: MessageType.SUCCESS);
      Future.delayed(
          Duration(seconds: 1), () => Get.to(() => LoginAfterGoogleAuth()));
    } else {
      Get.snackbar('Error', 'user data is empty');
    }
    BotToast.closeAllLoading();
  }).catchError((onError) {
    BotToast.closeAllLoading();
    Get.snackbar('Error', onError.toString());
  });
}

class LoginAfterGoogleAuth extends StatelessWidget {
  LoginAfterGoogleAuth({super.key});

  LoginController controller = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.screenWidth(30)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserInput(
                maxLength: kDebugMode ? null : 9,
                keyboardType: TextInputType.phone,
                validator: (number) {
                  // return null;
                  //
                  return kDebugMode ? null : numberValidator(number!);
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
                key: Key('google login'),
                onPressed: () {
                  formKey.currentState!.validate()
                      ? controller.registerAfterGoogleAuth(
                          email: userGoogleEmail.value,
                          userName: userGoogleName.value)
                      : null;
                },
                text: tr("continue_lb"),
              ),
              context.screenWidth(9).ph,
            ],
          ),
        ),
      ),
    );
  }
}
