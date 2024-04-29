// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

buildAwsomeDialog(
    {required BuildContext context,
    required String content,
    required String firstBtnText,
    required String secondBtnText,
    void Function()? firstBtn,
    void Function()? secondBtn,
    DialogType? dialogType}) {
  return AwesomeDialog(
      btnOkColor: Colors.green,
      dialogBackgroundColor: Get.theme.scaffoldBackgroundColor,
      context: context,
      animType: AnimType.scale,
      dialogType: dialogType ?? DialogType.warning,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomText(
              text: content,
              textType: TextStyleType.SUBTITLE,
            ),
          ),
        ],
      ),
      btnCancelOnPress: () {
        secondBtn!();
      },
      btnCancelText: secondBtnText,
      btnOkText: firstBtnText,
      btnOkOnPress: () {
        firstBtn!();
        // context.pushRepalceme(const LoginView());
      }).show();
}
