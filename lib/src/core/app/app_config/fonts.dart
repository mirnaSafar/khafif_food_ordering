import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class AppFonts {
  final BuildContext context;
  double headerBig = 36;
  double header = 28;
  double title = 20;
  double subtitle = 18;
  double body = 16;
  double bodySmall = 14;
  double small = 12;
  AppFonts(this.context) {
    headerBig = context.screenWidth(11.5); //36
    header = context.screenWidth(14.5); //28
    title = context.screenWidth(20.5); //20
    subtitle = context.screenWidth(23); //18
    body = context.screenWidth(26); //16
    bodySmall = context.screenWidth(29); //14
    small = context.screenWidth(34); //12
  }
}
