import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import '../../../core/app/app_config/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? height;

  final double? fontsize;
  final Color? color;
  final Color? textColor;
  final TextStyleType? textStyleType;
  final Color? borderColor;
  // final Function? onPressed;
  final void Function()? onPressed;
  final String? imageName;
  final bool? loader;
  final BorderRadiusGeometry? borderRadius;
  const CustomButton({
    super.key,
    this.text,
    this.color,
    this.textColor,
    this.borderColor,
    this.onPressed,
    this.imageName,
    this.loader = false,
    this.fontsize,
    this.child,
    this.height,
    this.textStyleType,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (loader!) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SpinKitCircle(
          color: color ?? AppColors.mainAppColor,
        ),
      );
    } else {
      return ElevatedButton(
          onPressed: () {
            onPressed!();
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              disabledForegroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              fixedSize: Size(
                size.width,
                height ?? context.screenHeight(14),
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(8)),
              ),
              backgroundColor: color ?? AppColors.mainAppColor,
              side: borderColor != null
                  ? BorderSide(
                      width: 1,
                      color: borderColor!,
                    )
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageName != null) ...[
                SvgPicture.asset('assets/images/$imageName.svg'),
                10.px,
              ],
              text != null
                  ? Flexible(
                      child: CustomText(
                        text: text!,
                        textColor: textColor,
                        darkTextColor: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontsize,
                        textType: textStyleType ?? TextStyleType.BODY,
                      ),
                    )
                  : child!,
            ],
          ));
    }
  }
}
