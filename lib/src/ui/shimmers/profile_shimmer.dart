import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

CustomShimmer pointsShimmer() {
  return CustomShimmer(
      isLoading: true,
      child: Container(
        width: screenWidth(12),
        height: screenWidth(40),
        color: Colors.white,
      ));
}
