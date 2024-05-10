import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

Widget shopsShimmer({
  required bool isLoading,
}) {
  return Expanded(
    child: CustomListView(
        itemCount: 8,
        vertical: true,
        // listViewHeight: screenHeight(1),
        separatorPadding: Get.context!.screenWidth(20).ph,
        itemBuilder: (context, index) => CustomShimmer(
              isLoading: isLoading,
              child: CustomContainer(
                  height: Get.context!.screenWidth(7),
                  backgroundColor: Colors.white,
                  shadowColor: AppColors.shadowColor,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  borderRadius: BorderRadius.circular(5),
                  padding: EdgeInsets.symmetric(
                      vertical: Get.context!.screenWidth(20),
                      horizontal: Get.context!.screenWidth(30)),
                  child: Container()),
            )).paddingAll(Get.context!.screenWidth(30)),
  );
}
