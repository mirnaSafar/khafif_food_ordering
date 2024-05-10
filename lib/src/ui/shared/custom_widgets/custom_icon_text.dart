// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomIconText extends StatelessWidget {
  CustomIconText(
      {super.key,
      this.imagename,
      this.imageHeight,
      this.imageWidth,
      this.textType,
      this.fontsize,
      required this.text,
      this.imagecolor,
      this.onTap,
      this.fontWeight,
      this.textcolor,
      this.image,
      this.mainAxisAlignment = MainAxisAlignment.start});
  final MainAxisAlignment? mainAxisAlignment;
  final String? imagename;
  final Widget? image;
  final double? imageHeight;
  final double? imageWidth;
  final TextStyleType? textType;
  final double? fontsize;
  final FontWeight? fontWeight;
  final String text;
  final Color? imagecolor;
  final Color? textcolor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.screenWidth(30)),
        child: Row(
          mainAxisAlignment: mainAxisAlignment!,
          children: [
            image ??
                SvgPicture.asset(
                  imagename!,
                  height: imageHeight ?? context.screenWidth(15),
                  width: imageWidth ?? context.screenWidth(15),
                  color: imagecolor ?? Theme.of(context).colorScheme.secondary,
                ),
            context.screenWidth(40).px,
            CustomText(
              textType: textType ?? TextStyleType.BODY,
              text: text,
              textColor: imagecolor ?? Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
              fontSize: fontsize,
            )
          ],
        ),
      ),
    );
  }
}
