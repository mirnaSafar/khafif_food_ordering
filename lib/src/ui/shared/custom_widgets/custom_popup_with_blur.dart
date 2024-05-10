// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_blur.dart';

class CustomPopupWithBlurWidget extends StatelessWidget {
  CustomPopupWithBlurWidget({
    this.blur = true,
    super.key,
    required this.child,
    required this.customBlurChildType,
  });
  final CustomBlurChildType customBlurChildType;
  final bool? blur;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (blur!)
          Positioned.fill(
            child: CustomBlurWidget(),
          ),
        if (customBlurChildType == CustomBlurChildType.BOTTOMSHEET) ...[
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: child,
          )
        ],
        if (customBlurChildType == CustomBlurChildType.DRAWER) ...[
          PositionedDirectional(
            top: 0,
            bottom: 0,
            start: 0,
            child: child,
          ),
        ],
        if (customBlurChildType == CustomBlurChildType.DIALOUG) ...[
          Center(child: child),
        ],
      ],
    );
  }
}
