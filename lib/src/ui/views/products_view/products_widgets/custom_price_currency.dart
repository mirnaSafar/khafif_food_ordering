// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomPriceCurrency extends StatelessWidget {
  CustomPriceCurrency({super.key, required this.price});
  final String price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          textType: TextStyleType.SMALL,
          text: tr('price_lb'),
          // darkTextColor: AppColors.mainBlackColor,
        ),
        CustomText(
            fontWeight: FontWeight.bold,
            textType: TextStyleType.SMALL,
            // darkTextColor: AppColors.mainBlackColor,
            text: '${formatPriceToInt(price)}'),
      ],
    );
  }
}
