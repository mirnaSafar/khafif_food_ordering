import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_row_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/otp_view/otp_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CustomPinCodeTextFields extends StatefulWidget {
  final int? length;
  final double? fieldHeight, fieldWidth;
  final void Function(String code) onCompleted;
  final String? obscuringCharacter;
  final String number;

  const CustomPinCodeTextFields(
      {super.key,
      this.length,
      this.fieldHeight,
      this.fieldWidth,
      required this.onCompleted,
      this.obscuringCharacter,
      required this.number});

  @override
  State<CustomPinCodeTextFields> createState() =>
      _CustomPinCodeTextFieldsState();
}

class _CustomPinCodeTextFieldsState extends State<CustomPinCodeTextFields>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;
  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
        print(appSignature);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  OtpController otpController = Get.put(OtpController());
  LoginController loginController = Get.put(LoginController());
  final CountdownController countdownController =
      CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (otpCode == null)
          const CustomText(
              text: "Listening for code...", textType: TextStyleType.BODYSMALL),
        screenWidth(30).ph,
        PinFieldAutoFill(
          textInputAction: TextInputAction.next,
          enableInteractiveSelection: false,
          autoFocus: true,
          decoration: BoxLooseDecoration(
              strokeColorBuilder: PinListenColorBuilder(
                AppColors.mainGreyColor,
                AppColors.greyColor,
              ),
              bgColorBuilder: FixedColorBuilder(Colors.grey[100]!),
              strokeWidth: 2,
              hintText: '****',
              textStyle: TextStyle(
                  color: AppColors.mainBlackColor, fontSize: AppFonts.title),
              radius: const Radius.circular(5),
              gapSpace: 20),

          cursor: Cursor(color: Colors.black, enabled: true, width: 1),
          // decoration: UnderlineDecoration(
          //     // hintText: '*',

          //     // obscureStyle:

          //     //     ObscureStyle(isTextObscure: true, obscureText: '*'),
          //     textStyle: TextStyle(
          //         fontSize: AppFonts.body, color: AppColors.mainBlackColor),
          //     colorBuilder: const FixedColorBuilder(Colors.transparent),
          //     bgColorBuilder: FixedColorBuilder(
          //       AppColors.mainGreyColor.withOpacity(0.3),
          //     )),
          onCodeSubmitted: (code) => widget.onCompleted(code),

          controller: otpController.textEditingController,
          currentCode: otpCode,
          onCodeChanged: (code) {
            otpController.otpCode.value = code!;
            otpController.countdownController.pause();
            if (code.length == 4) {
              widget.onCompleted(code);
              FocusScope.of(context).unfocus();
            }
          },
          codeLength: 4,
        ),
        screenWidth(15).ph,
        Countdown(
          onFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Timer is done!'),
              ),
            );
          },
          controller: countdownController,
          seconds: 60,
          // double.parse(storage.otpTime).toInt() * 60,
          interval: const Duration(milliseconds: 1000),
          build: (context, currentRemainingTime) {
            if (currentRemainingTime != 0.0) {
              return Center(
                  child: CustomText(
                      text: '$currentRemainingTime ${tr('sec_left_lb')}',
                      textType: TextStyleType.SMALL));
            } else {
              return CustomRowText(
                  onTap: () {
                    // countdownController.onRestart!();
                    loginController.login();

                    countdownController.restart();
                    // countdownController = CountdownController(autoStart: true);
                    // _handleResendCodeTap();
                  },
                  firstText: tr('code_not_received_lb'),
                  linkText: tr('resend_code_lb'),
                  linkColor: AppColors.greyColor,
                  firstColor: AppColors.greyColor,
                  textStyleType: TextStyleType.BODY);
            }
          },
        ),
      ],
    );

//     return Column(
//       children: [
//         if (otpCode == null)
//           const CustomText(
//               text: "Listening for code...", textType: TextStyleType.BODYSMALL),
//         screenWidth(30).ph,
//         PinCodeTextField(

//           appContext: context,
//           pastedTextStyle: TextStyle(
//             color: Colors.green.shade600,
//             fontWeight: FontWeight.bold,
//           ),
//           obscureText: false,
//           keyboardType: TextInputType.number,

//           length: widget.length ?? 4,
//           // obscureText: true,
//           animationType: AnimationType.fade,
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.box,
//             borderRadius: BorderRadius.circular(4),
//             fieldHeight: widget.fieldHeight ?? screenWidth(7),
//             fieldWidth: widget.fieldWidth ?? screenWidth(7),
//             activeFillColor: AppColors.fieldBorderColor,
//             inactiveColor: AppColors.greyColor,
//             inactiveFillColor: AppColors.fieldBorderColor,
//             disabledColor: Colors.grey,
//             selectedColor: AppColors.mainGreyColor,
//             selectedFillColor: AppColors.fieldBorderColor,
//             errorBorderColor: Colors.grey,
//             borderWidth: 1,
//             activeColor: AppColors.mainGreyColor,
//           ),

//           hintCharacter: '*',
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           animationDuration: const Duration(milliseconds: 300),
//           // backgroundColor: Colors.white,
//           enableActiveFill: true,
//           enablePinAutofill: true,
//           errorAnimationController: otpController.errorController,
//           controller: otpController.textEditingController,
//           obscuringCharacter: widget.obscuringCharacter ?? '*',
//           onCompleted: (value) => widget.onCompleted(value),
//           // ??  otpController.codeVerificationProcess(value);

//           onChanged: (value) {},
//         ),
//         Countdown(
//           controller: countdownController,
//           seconds: double.parse(storage.otpTime).toInt() * 60,
//           interval: const Duration(milliseconds: 1000),
//           build: (context, currentRemainingTime) {
//             if (currentRemainingTime == 0.0) {
//               return CustomRowText(
//                   onTap: () {
//                     loginController.login();
//                     countdownController.restart();
//                     // _handleResendCodeTap();
//                     countdownController = CountdownController(autoStart: true);
//                   },
//                   firstText: tr('code_not_received_lb'),
//                   linkText: tr('resend_code_lb'),
//                   linkColor: AppColors.greyColor,
//                   firstColor: AppColors.greyColor,
//                   textStyleType: TextStyleType.BODY);
//             } else {
//               return Center(
//                   child: CustomText(
//                       text: '$currentRemainingTime s left',
//                       // '0:'
//                       //     '${'{$}'}  '
//                       textType: TextStyleType.SMALL));
//             }
//           },
//         ),
//       ],
//     );
//   }
  }
}
