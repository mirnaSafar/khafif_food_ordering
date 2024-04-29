import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

Widget cartProductsShimmer() {
  return CustomListView(
    vertical: true,
    itemCount: 4,
    itemBuilder: (p0, p1) => CustomShimmer(
      isLoading: true,
      child: Row(
        children: [
          Container(
            width: screenWidth(12),
            height: screenWidth(10),
            color: Colors.white, // Placeholder color
          ),
          screenWidth(30).px,
          Container(
            width: screenWidth(1.3),
            height: screenWidth(10),
            color: Colors.white, // Placeholder color
          ),
        ],
      ),
    ),
    separatorPadding: screenWidth(25).ph,
  ).paddingOnly(top: screenWidth(30));
}

CustomShimmer totalShimmer() {
  return CustomShimmer(
    isLoading: true,
    child: Container(
      width: screenWidth(4),
      height: screenWidth(20),
      color: Colors.white, // Placeholder color
    ),
  );
}

CustomShimmer totalCountShimmer() {
  return CustomShimmer(
    isLoading: true,
    child: Container(
      width: screenWidth(11),
      height: screenWidth(27),
      color: Colors.white, // Placeholder color
    ),
  );
}
