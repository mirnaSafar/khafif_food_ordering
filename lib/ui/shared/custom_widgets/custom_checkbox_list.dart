import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_radio.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomCheckBoxList extends StatefulWidget {
  const CustomCheckBoxList(
      {super.key,
      required this.index,
      this.selectedValue = -1,
      this.onTap,
      required this.text});
  final int index;
  final String text;

  final int? selectedValue;
  final void Function()? onTap;
  @override
  State<CustomCheckBoxList> createState() => _CustomCheckBoxListState();
}

class _CustomCheckBoxListState extends State<CustomCheckBoxList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenWidth(80), horizontal: screenWidth(200)),
        child: CustomContainer(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
          containerStyle: ContainerStyle.NORMAL,
          backgroundColor: widget.selectedValue == widget.index
              ? AppColors.mainAppColor
              : AppColors.mainWhiteColor,
          // width: screenWidth(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRadio(
                  width: screenWidth(25),
                  height: screenWidth(25),
                  borderColor: AppColors.buttonTextColor,
                  fillColor: AppColors.buttonTextColor,
                  value: widget.index,
                  onTaped: (value) {
                    if (value != null) {
                      widget.onTap?.call();
                    }
                  },
                  selected: widget.selectedValue ?? -1),
              screenWidth(45).px,
              CustomText(
                text: widget.text,
                darkTextColor: AppColors.mainBlackColor,
                textType: TextStyleType.SMALL,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
