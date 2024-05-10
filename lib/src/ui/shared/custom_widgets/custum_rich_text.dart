// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';

class CustomRichText extends StatelessWidget {
  CustomRichText(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.firstFontWeight,
      this.secondFontWeight,
      this.firstFontSize,
      this.secondFontSize,
      this.firstColor,
      this.secondColor});
  final String firstText, secondText;
  final FontWeight? firstFontWeight, secondFontWeight;
  final double? firstFontSize, secondFontSize;
  final Color? firstColor, secondColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: firstFontSize ?? AppFonts(context).body,
          color: firstColor ?? Theme.of(context).colorScheme.secondary,
          fontWeight: firstFontWeight ?? FontWeight.w400,
        ),
        text: firstText,
        children: [
          TextSpan(
            text: secondText,
            style: TextStyle(
              color: secondColor ?? Theme.of(context).colorScheme.secondary,
              fontSize: secondFontSize ?? AppFonts(context).body,
              fontWeight: secondFontWeight ?? FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
