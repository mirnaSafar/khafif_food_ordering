import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

Widget addresseShimmer({required bool isLoading}) {
  return CustomListView(
    listViewHeight: screenHeight(1),
    itemCount: 4,
    vertical: true,
    itemBuilder: (p0, p1) => CustomShimmer(
      isLoading: true,
      child: Padding(
          padding: EdgeInsets.only(bottom: screenWidth(30)),
          child: CustomContainer(
              containerStyle: ContainerStyle.BIGSQUARE,
              blurRadius: 4,
              shadowColor: AppColors.shadowColor,
              offset: const Offset(0, 4),
              padding: EdgeInsets.all(screenWidth(15)),
              width: screenWidth(1),
              height: screenHeight(7),
              child: Container())),
    ),
    separatorPadding: 0.ph,
  );
}
