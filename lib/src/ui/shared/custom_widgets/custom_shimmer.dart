import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  // ignore: prefer_const_constructors_in_immutables
  CustomShimmer({super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Get.theme.colorScheme.surface,
        highlightColor: Get.theme.colorScheme.onSurface,
        child: child,
      );
    } else {
      return child;
    }
  }
}
