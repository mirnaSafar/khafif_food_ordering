import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomPriceCurrency extends StatelessWidget {
  const CustomPriceCurrency({super.key, required this.price});
  final String price;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          textType: TextStyleType.SMALL,
          text: 'price',
          darkTextColor: AppColors.mainBlackColor,
        ),
        CustomText(
            fontWeight: FontWeight.bold,
            textType: TextStyleType.SMALL,
            darkTextColor: AppColors.mainBlackColor,
            text: price),
      ],
    );
  }
}
