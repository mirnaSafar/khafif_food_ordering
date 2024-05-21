// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_carousel_slider.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';

Widget categoriesShimmer({required bool scrolled, required bool isLoading}) {
  return CustomShimmer(
    isLoading: isLoading,
    child: Padding(
      padding: EdgeInsets.all(scrolled ? 0 : Get.context!.screenWidth(200)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.context!.screenWidth(600),
            vertical: Get.context!.screenWidth(100)),
        child: CustomContainer(
          containerStyle: !scrolled ? ContainerStyle.CYLINDER : null,
          borderRadius: BorderRadius.circular(20),
          width: Get.context!.screenWidth(scrolled ? 4.5 : 5.5),
          padding: EdgeInsets.symmetric(
              vertical: scrolled ? 0 : Get.context!.screenWidth(50)),
          child: Container(),
        ),
      ),
    ),
  );
}

Widget productsShimmer({
  required bool isLoading,
}) {
  return CustomShimmer(
    isLoading: isLoading,
    child: CustomContainer(
        blurRadius: 4,
        shadowColor: AppColors.shadowColor,
        offset: Offset(0, 4),
        containerStyle: ContainerStyle.BIGSQUARE,
        padding: EdgeInsets.symmetric(
            horizontal: Get.context!.screenWidth(50),
            vertical: Get.context!.screenWidth(90)),
        // borderRadius: 19,
        // height: 207,
        width: Get.context!.screenWidth(2.3),
        child: Container()),
  );
}

Widget searchProductsShimmer({
  required bool isLoading,
}) {
  return CustomShimmer(
      isLoading: isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.context!.screenWidth(10)),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: Get.context!.screenWidth(20),
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.context!.screenWidth(80)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  width: Get.context!.screenWidth(8),
                  height: Get.context!.screenWidth(8),
                ));
          },
        ),
      ));
}

Widget bannersShimmer({
  required bool isLoading,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Get.context!.screenWidth(30),
        horizontal: Get.context!.screenWidth(20)),
    child: CustomCarouselSlider(
      autoPlay: true,
      scrolled: true,
      padEnds: false,
      sliderHeight: Get.context!.screenHeight(5),
      itemCount: 2,
      itemBuilder: (context, int index, int realIndex) => CustomShimmer(
        isLoading: isLoading,
        child: CustomShimmer(
          isLoading: isLoading,
          child: CustomContainer(

              // borderRadius: 19,
              // height: 207,
              child: Container()),
        ),
      ),
    ),
  );
}

Widget productDetailsShimmer({
  required bool isLoading,
}) {
  return CustomShimmer(
    isLoading: isLoading,
    child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.context!.screenWidth(20)),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: CustomContainer(
                width: Get.context!.screenWidth(3),
                height: Get.context!.screenWidth(4),
                child: Container(),
              ),
            ),
            Get.context!.screenWidth(10).ph,
            Row(
              children: [
                CustomContainer(
                  width: Get.context!.screenWidth(3),
                  child: Container(
                    height: Get.context!.screenWidth(30),
                  ),
                ),
                Get.context!.screenWidth(20).px,
                CustomContainer(
                  width: Get.context!.screenWidth(2),
                  child: Container(
                    height: Get.context!.screenWidth(30),
                  ),
                ),
              ],
            ),
            Get.context!.screenWidth(30).ph,

            CustomContainer(
              width: Get.context!.screenWidth(3),
              child: Container(
                height: Get.context!.screenWidth(20),
              ),
            ),
            Get.context!.screenWidth(3).ph,

            CustomListView(
              itemCount: 3,
              separatorPadding: 0.px,
              listViewHeight: Get.context!.screenHeight(18),
              itemBuilder: (context, index) => CustomContainer(
                width: Get.context!.screenWidth(4),
                child: Container(
                  height: Get.context!.screenWidth(30),
                ),
              ),
            ),
            Get.context!.screenWidth(20).ph, // CustomListView(
            CustomContainer(
              width: Get.context!.screenWidth(3),
              child: Container(
                height: Get.context!.screenWidth(20),
              ),
            ),
            Get.context!.screenWidth(30).ph,
            CustomListView(
              vertical: true,
              itemCount: 6,
              listViewHeight: Get.context!.screenWidth(2),
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              itemBuilder: (p0, p1) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.context!.screenWidth(30)),
                child: CustomContainer(
                  width: Get.context!.screenWidth(2.3),
                  child: CustomContainer(
                    // width:  Get.context! .screenWidth(3),
                    child: Container(
                        // height:  Get.context! .screenWidth(20),
                        ),
                  ),
                ),
              ),
              separatorPadding: 60.ph,
            )
            // .insert(index, value)
          ]),
        )),
  );
}
