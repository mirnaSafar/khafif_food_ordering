// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomInfoWidget extends StatelessWidget {
  const CustomInfoWidget(
      {super.key,
      required this.text,
      required this.imagename,
      required this.onTap});
  final String text;
  final String imagename;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomContainer(
          borderRadius: BorderRadius.circular(8),
          backgroundColor: AppColors.mainWhiteColor,
          width: context.screenWidth(5),
          height: context.screenWidth(4.9),
          blurRadius: 4,
          shadowColor: AppColors.shadowColor,
          offset: Offset(0, 4),
          // padding:  EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagename,
                width: context.screenWidth(13),
                height: context.screenWidth(13),
              ),
              context.screenHeight(120).ph,
              CustomText(
                darkTextColor: AppColors.mainBlackColor,
                text: text,
                fontWeight: FontWeight.w600,
                textType: TextStyleType.BODYSMALL,
              )
            ],
          )),
    );
  }
}
////////////////////////