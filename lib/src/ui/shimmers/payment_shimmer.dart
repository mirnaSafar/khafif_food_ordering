// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

CustomListView paymentMethodsShimmer() {
  return CustomListView(
      physics: NeverScrollableScrollPhysics(),
      itemCount: Platform.isAndroid ? 3 : 4,
      separatorPadding: Get.context!.screenWidth(30).ph,
      vertical: true,
      listViewHeight: Get.context!.screenHeight(2.3),
      itemBuilder: (context, index) => CustomShimmer(
            isLoading: true,
            child: Container(
              height: Get.context!.screenWidth(5),
              color: AppColors.mainWhiteColor,
            ),
          ));
}
