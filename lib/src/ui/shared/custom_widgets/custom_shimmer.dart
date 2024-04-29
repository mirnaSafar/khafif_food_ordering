import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomShimmer(
      {super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[100]!,
        child: child,
      );
    } else {
      return child;
    }
  }
}
