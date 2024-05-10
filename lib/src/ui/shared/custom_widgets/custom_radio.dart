// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';

class CustomRadio extends StatelessWidget {
  final dynamic value;
  final Color? fillColor;
  final Color? borderColor;
  final Function onTaped;
  final dynamic selected;
  final double? width;
  final double? height;
  final double? scaleX;
  final double? scaleY;

  CustomRadio({
    super.key,
    required this.value,
    this.fillColor,
    required this.onTaped,
    required this.selected,
    this.width,
    this.height,
    this.scaleX,
    this.scaleY,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.transparent,
      ),
      child: Radio(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        fillColor: MaterialStateColor.resolveWith(
            (states) => fillColor ?? AppColors.mainAppColor),
        activeColor: fillColor ?? AppColors.mainAppColor,
        value: value,
        groupValue: selected,
        onChanged: (value) {
          onTaped(value);
        },
      ),
    );
  }
}
