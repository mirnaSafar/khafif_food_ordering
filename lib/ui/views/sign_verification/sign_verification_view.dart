import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_pin_code_fields.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/otp_view/otp_controller.dart';

class SignVerification extends StatefulWidget {
  const SignVerification({super.key, required this.number});
  final String number;
  @override
  State<SignVerification> createState() => _SignVerificationState();
}

class _SignVerificationState extends State<SignVerification> {
  @override
  void initState() {
    super.initState();
  }

  OtpController otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    var secondStepEnterRecievedCode = [
      CustomText(
        textAlign: TextAlign.start,
        text: tr('enter_code_lb'),
        textType: TextStyleType.BODY,
      ),
      screenHeight(8).ph,
      Obx(() {
        print(otpController.current);
        return CustomPinCodeTextFields(
            onCompleted: (String value) {
              otpController.otpCode.value = value;
              otpController.verifyPhone(widget.number);
            },
            number: widget.number);
      }),
    ];

    return Scaffold(
      appBar: const CustomAppbar(),
      body: PopScope(
        onPopInvoked: (didPop) => storage.setTokenIno(''),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(25), vertical: screenWidth(4)),
            child: Obx(() {
              print(otpController.current.value);
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: tr('verify_your_number_lb'),
                      fontWeight: FontWeight.w800,
                      textType: TextStyleType.HEADER,
                    ),
                    ...secondStepEnterRecievedCode,
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}
