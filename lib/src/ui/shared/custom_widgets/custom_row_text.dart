// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomRowText extends StatelessWidget {
  CustomRowText(
      {super.key,
      required this.firstText,
      required this.linkText,
      this.onTap,
      this.firstColor,
      this.linkColor,
      this.textStyleType,
      this.fontsize,
      this.fontWeight});
  final Color? firstColor, linkColor;
  final String firstText, linkText;
  final TextStyleType? textStyleType;
  final double? fontsize;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          textColor: firstColor,
          text: firstText,
          // customtextStyle: Theme.of(context).textTheme.bodyMedium,
          fontSize: fontsize,
          fontWeight: fontWeight ?? FontWeight.w400,
          textType: textStyleType ?? TextStyleType.BODYSMALL,
        ),
        // screenWidth(30).px,
        InkWell(
          onTap: onTap,
          child: Text(linkText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: linkColor ?? Theme.of(context).primaryColor,
                    fontWeight: fontWeight ?? FontWeight.w400,
                  )),
        ),
      ],
    );
  }
}
