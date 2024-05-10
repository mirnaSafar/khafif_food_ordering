// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';

showBrowsingDialogAlert(
  BuildContext context,
) {
  buildAwsomeDialog(
    // dialogType: DialogType.INFO,
    context: context,
    content: tr('browsing_alert_lb'),
    firstBtnText: tr('login_lb'),
    secondBtnText: tr('cancel_lb'),
    firstBtn: () => Get.offAll(LoginView()),
  );
}

warninDialog(
    {required BuildContext context,
    required String content,
    required void Function()? okBtn}) {
  buildAwsomeDialog(
    context: context,
    content: content,
    secondBtnText: tr('ok_lb'),
    firstBtnText: tr('cancel_lb'),
    secondBtn: () {
      // context.pop();
      okBtn!();
    },
  );
}

warninDialogWithoutAction({
  required BuildContext context,
  required String content,
}) {
  buildAwsomeDialog(
    showMessageWithoutActions: true,
    context: context,
    content: content,
  );
}
