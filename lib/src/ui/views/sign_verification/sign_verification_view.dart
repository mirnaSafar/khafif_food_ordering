// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_pin_code_fields.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/otp_view/otp_controller.dart';

class SignVerification extends StatefulWidget {
  SignVerification({super.key, required this.number});
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
      context.screenHeight(8).ph,
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
      appBar: CustomAppbar(),
      body: PopScope(
        onPopInvoked: (didPop) => storage.setTokenIno(''),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth(25),
                vertical: context.screenWidth(4)),
            child: Obx(() {
              print(otpController.current.value);
              return FutureBuilder(
                  future: whenNotZero(
                    Stream<double>.periodic(const Duration(milliseconds: 50),
                        (x) => MediaQuery.of(context).size.width),
                  ),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > 0) {
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
                      }
                    }
                    return Container();
                  });
            }),
          ),
        ),
      ),
    );
  }
}
