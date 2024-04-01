import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_radio.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomPaymentMethod extends StatefulWidget {
  const CustomPaymentMethod(
      {super.key,
      required this.value,
      required this.selected,
      required this.onTaped,
      required this.text,
      required this.image});
  final int value, selected;
  final Function onTaped;
  final String text;
  final Widget image;
  @override
  State<CustomPaymentMethod> createState() => _CustomPaymentMethodState();
}

class _CustomPaymentMethodState extends State<CustomPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTaped(widget.value),
      child: CustomContainer(
        containerStyle: ContainerStyle.SMALLSQUARE,
        backgroundColor: AppColors.mainWhiteColor,
        padding: EdgeInsets.symmetric(horizontal: screenWidth(30)),
        height: screenHeight(11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomRadio(
                    value: widget.value,
                    onTaped: widget.onTaped,
                    selected: widget.selected),
                screenWidth(50).px,
                CustomText(
                  darkTextColor: AppColors.mainBlackColor,
                  text: widget.text,
                  textType: TextStyleType.BODYSMALL,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            widget.image,
          ],
        ),
      ),
    );
  }
}
