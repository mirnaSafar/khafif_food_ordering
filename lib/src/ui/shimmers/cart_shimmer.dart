import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
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
            width: Get.context!.screenWidth(12),
            height: Get.context!.screenWidth(10),
            color: Colors.white, // Placeholder color
          ),
          Get.context!.screenWidth(30).px,
          Container(
            width: Get.context!.screenWidth(1.3),
            height: Get.context!.screenWidth(10),
            color: Colors.white, // Placeholder color
          ),
        ],
      ),
    ),
    separatorPadding: Get.context!.screenWidth(25).ph,
  ).paddingOnly(top: Get.context!.screenWidth(30));
}

CustomShimmer totalShimmer() {
  return CustomShimmer(
    isLoading: true,
    child: Container(
      width: Get.context!.screenWidth(4),
      height: Get.context!.screenWidth(20),
      color: Colors.white, // Placeholder color
    ),
  );
}

CustomShimmer totalCountShimmer() {
  return CustomShimmer(
    isLoading: true,
    child: Container(
      width: Get.context!.screenWidth(11),
      height: Get.context!.screenWidth(27),
      color: Colors.white, // Placeholder color
    ),
  );
}
