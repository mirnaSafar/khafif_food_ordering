import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomNameCalories extends StatelessWidget {
  const CustomNameCalories(
      {super.key, required this.productname, required this.calory});
  final String productname;
  final String calory;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth(3.6),
          height: screenWidth(19),
          child: SingleChildScrollView(
            child: CustomText(
                textAlign: TextAlign.start,
                textType: TextStyleType.SMALL,
                darkTextColor: AppColors.mainBlackColor,
                fontWeight: FontWeight.bold,
                text: productname),
          ),
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/fire.png',
            ),
            screenWidth(80).px,
            CustomText(
                textType: TextStyleType.SMALL,
                darkTextColor: AppColors.mainBlackColor,
                text: '$calory Calories'),
          ],
        ),
      ],
    );
  }
}
