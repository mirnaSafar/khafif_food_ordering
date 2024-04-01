import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomPrice extends StatelessWidget {
  const CustomPrice({
    super.key,
    required this.price,
    this.color,
    this.bold = true,
    this.pricesize,
    this.dollarsize,
    this.textAlign,
  });

  final String price;

  final TextAlign? textAlign;
  final Color? color;
  final bool? bold;
  final double? pricesize;
  final double? dollarsize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          right: -7,
          child: CustomText(
            textType: TextStyleType.CUSTOM,
            text: '\$',
            textColor: color ?? AppColors.mainAppColor,
            fontSize: dollarsize ?? 12,
          ),
        ),
        CustomText(
          textAlign: textAlign ?? TextAlign.start,
          text: price,
          textColor: color ?? AppColors.mainAppColor,
          fontSize: pricesize ?? 20,
          textType: TextStyleType.CUSTOM,
        ),
      ],
    );
  }
}
