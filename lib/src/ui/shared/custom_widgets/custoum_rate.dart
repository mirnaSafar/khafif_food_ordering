// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CustomRate extends StatefulWidget {
  CustomRate({
    super.key,
    this.size,
    this.enableRate = false,
    this.rateValue,
  });
  final double? size;
  final bool? enableRate;

  final double? rateValue;

  @override
  State<CustomRate> createState() => _CustomRateState();
}

class _CustomRateState extends State<CustomRate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        InkWell(
          onTap: widget.enableRate!
              ? () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => rateDialog,
                  );
                }
              : null,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.mainAppColor,
                size: widget.size ?? w * 0.03,
              ),
              CustomText(
                text: '4',
                textColor: AppColors.mainAppColor,
                fontSize: widget.size ?? w * 0.03,
                textType: TextStyleType.SMALL,
              )
            ],
          ),
        ),
      ],
    );
  }
}

final rateDialog = RatingDialog(
    enableComment: false,
    initialRating: 4,
    title: Text(
      tr('khafif_rate_title'),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: AppFonts(Get.context!).body),
    ),
    message: Text(
      tr('khafif_rate_message'),
      textAlign: TextAlign.center,
      style: TextStyle(
          height: 2.2,
          fontWeight: FontWeight.w400,
          fontSize: AppFonts(Get.context!).small),
    ),
    submitButtonText: tr('submit_lb'),
    onCancelled: () {},
    submitButtonTextStyle: TextStyle(color: AppColors.greyTextColor),
    onSubmitted: (response) {});
