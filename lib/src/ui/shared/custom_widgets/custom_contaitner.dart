import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';

enum ContainerStyle {
  NORMAL,
  BIGSQUARE,
  SMALLSQUARE,
  CYLINDER,
  CIRCLE,
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      this.backgroundColor,
      this.borderRadius,
      this.padding,
      required this.child,
      this.height,
      this.width,
      this.offset,
      this.blurRadius,
      this.shadowColor,
      this.containerStyle});

  final Color? backgroundColor;
  final dynamic borderRadius;
  final dynamic padding;
  final double? height;
  final double? width;
  final Widget child;
  final Offset? offset;
  final double? blurRadius;
  final Color? shadowColor;
  final ContainerStyle? containerStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: containerStyle == null
          ? BoxDecoration(boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ], color: backgroundColor, borderRadius: borderRadius)
          : decoration,
      child: child,
    );
  }

  BoxDecoration get decoration {
    switch (containerStyle) {
      case ContainerStyle.NORMAL:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(8));

      case ContainerStyle.SMALLSQUARE:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(8));
      case ContainerStyle.CIRCLE:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(100));

      case ContainerStyle.BIGSQUARE:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: borderRadius ?? BorderRadius.circular(30));

      case ContainerStyle.CYLINDER:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(42));

      default:
        return BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: shadowColor ?? AppColors.backgroundColor,
                  blurRadius: blurRadius ?? 0,
                  offset: offset ?? const Offset(0, 0))
            ],
            color: backgroundColor ?? AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(8));
    }
  }
}
