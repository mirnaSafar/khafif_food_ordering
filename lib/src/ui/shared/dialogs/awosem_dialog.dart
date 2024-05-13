// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

buildAwsomeDialog({
  required BuildContext context,
  required String content,
  String? firstBtnText,
  String? secondBtnText,
  void Function()? firstBtn,
  void Function()? secondBtn,
  MessageType? messageType,
  Color? firstBtnColor,
  Color? secondBtnColor,
  bool? showMessageWithoutActions = false,
}) {
  return CustomToast.AwesomeDialog(
      firstBtnFunction: firstBtn,
      firstBtnColor: firstBtnColor,
      secondBtnColor: secondBtnColor,
      secBtnFunction: secondBtn,
      showMessageWithoutActions: showMessageWithoutActions,
      message: content,
      firstBtnText: firstBtnText,
      secondBtnText: secondBtnText,
      messageType: messageType);
  // autoHide:
  //     showMessageWithoutActions! ?  Duration(seconds: 3) : null,
  // btnOkColor: Colors.green,
  // dialogBackgroundColor: Get.theme.scaffoldBackgroundColor,
  // context: context,
  // animType: AnimType.SCALE,
  // dialogType: dialogType ?? DialogType.WARNING,
  // body: Column(
  //   mainAxisSize: MainAxisSize.min,
  //   children: [
  //     Flexible(
  //       child: CustomText(
  //         text: content,
  //         textType: TextStyleType.SUBTITLE,
  //       ),
  //     ),
  //     if (showMessageWithoutActions) screenWidth(30).ph,
  //   ],
  // ),
  // btnCancelOnPress: showMessageWithoutActions
  //     ? null
  //     : () {
  //         secondBtn!();
  //       },
  // btnCancelText: showMessageWithoutActions ? null : secondBtnText,
  // btnOkText: showMessageWithoutActions ? null : firstBtnText,
  // btnOkOnPress: showMessageWithoutActions
  //     ? null
  //     : () {
  //         firstBtn!();
  //         // context.pushRepalceme( LoginView());
  // })
  // .show();
}
