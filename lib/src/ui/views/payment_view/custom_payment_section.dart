import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomPaymentSection extends StatelessWidget {
  final String titletext;
  final Color? titletextcolor;
  final TextStyleType? titletextStyleType;
  final String pricetext;
  final Color? pricetextcolor;
  final TextStyleType? pricetextStyleType;
  final FontWeight? pricefontweight;

  const CustomPaymentSection(
      {super.key,
      required this.titletext,
      this.titletextcolor,
      this.titletextStyleType,
      required this.pricetext,
      this.pricetextcolor,
      this.pricetextStyleType,
      this.pricefontweight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          fontWeight: FontWeight.w500,
          text: titletext,
          textColor: titletextcolor ?? AppColors.greyColor,
          textType: titletextStyleType ?? TextStyleType.BODYSMALL,
          // textColor: AppColors.bodyTextColor,
        ),
        CustomText(
          text: pricetext,
          textType: pricetextStyleType ?? TextStyleType.BODY,
          fontWeight: pricefontweight ?? FontWeight.w500,
        )
      ],
    );
  }
}
