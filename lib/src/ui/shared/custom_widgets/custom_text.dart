import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_theme.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

enum TextStyleType {
  HEADER, //28
  TITLE, // 20px
  SUBTITLE, // 18px
  BODY, // 16px
  BODYSMALL, // 14px
  SMALL, // 12px
  CUSTOM,
}

class CustomText extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomText({
    super.key,
    this.textColor,
    this.textAlign,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    required this.text,
    required this.textType,
    this.customtextStyle,
    this.decoration,
    this.darkTextColor,
  });

  final Color? textColor;
  final Color? darkTextColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final TextStyleType textType;
  final TextStyle? customtextStyle;
  final TextDecoration? decoration;
  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  AppTheme themeController = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        print(appTheme.isDarkMode.value);
        return Text(widget.text,
            selectionColor: Get.theme.colorScheme.secondary,

            // overflow: TextOverflow.ellipsis,
            textAlign: widget.textAlign ?? TextAlign.center,
            style: widget.customtextStyle ?? textStyle);
      },
    );
  }

  TextStyle get textStyle {
    return TextStyle(
      decoration: widget.decoration,
      fontWeight: widget.fontWeight,
      color: !context.isDarkMode
          ? (widget.textColor ?? context.theme.colorScheme.secondary)
          : widget.darkTextColor ?? AppColors.mainWhiteColor,
      fontSize: costumFontsize,
    );
  }

  double get costumFontsize {
    switch (widget.textType) {
      case TextStyleType.HEADER:
        return AppFonts(context).header;

      case TextStyleType.TITLE:
        return AppFonts(context).title;

      case TextStyleType.SUBTITLE:
        return AppFonts(context).subtitle;

      case TextStyleType.BODY:
        return AppFonts(context).body;

      case TextStyleType.BODYSMALL:
        return AppFonts(context).bodySmall;

      case TextStyleType.SMALL:
        return AppFonts(context).small;

      case TextStyleType.CUSTOM:
        return widget.fontSize ?? context.screenWidth(20);
    }
  }
}
