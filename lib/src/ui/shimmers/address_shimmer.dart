// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

Widget addresseShimmer({required bool isLoading}) {
  return CustomListView(
    listViewHeight: Get.context!.screenHeight(1),
    itemCount: 4,
    vertical: true,
    itemBuilder: (p0, p1) => CustomShimmer(
      isLoading: true,
      child: Padding(
          padding: EdgeInsets.only(bottom: Get.context!.screenWidth(30)),
          child: CustomContainer(
              containerStyle: ContainerStyle.BIGSQUARE,
              blurRadius: 4,
              shadowColor: AppColors.shadowColor,
              offset: Offset(0, 4),
              padding: EdgeInsets.all(Get.context!.screenWidth(15)),
              width: Get.context!.screenWidth(1),
              height: Get.context!.screenHeight(7),
              child: Container())),
    ),
    separatorPadding: 0.ph,
  );
}
