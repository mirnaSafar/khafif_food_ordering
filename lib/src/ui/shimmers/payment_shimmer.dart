import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

CustomListView paymentMethodsShimmer() {
  return CustomListView(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorPadding: screenWidth(30).ph,
      vertical: true,
      listViewHeight: screenHeight(2.3),
      itemBuilder: (context, index) => CustomShimmer(
            isLoading: true,
            child: Container(
              height: screenWidth(5),
              color: AppColors.mainWhiteColor,
            ),
          ));
}
