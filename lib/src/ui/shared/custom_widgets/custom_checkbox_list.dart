// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_radio.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomCheckBoxList extends StatefulWidget {
  CustomCheckBoxList(
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
            vertical: context.screenWidth(80),
            horizontal: context.screenWidth(200)),
        child: CustomContainer(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth(40)),
          containerStyle: ContainerStyle.NORMAL,
          backgroundColor: widget.selectedValue == widget.index
              ? AppColors.mainAppColor
              : Get.theme.colorScheme.background,
          shadowColor: Get.theme.colorScheme.background,

          // width:  context .screenWidth(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRadio(
                  width: context.screenWidth(25),
                  height: context.screenWidth(25),
                  borderColor: Get.theme.colorScheme.secondary,
                  fillColor: Get.theme.colorScheme.secondary,
                  value: widget.index,
                  onTaped: (value) {
                    if (value != null) {
                      widget.onTap?.call();
                    }
                  },
                  selected: widget.selectedValue ?? -1),
              context.screenWidth(45).px,
              CustomText(
                text: widget.text,
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
