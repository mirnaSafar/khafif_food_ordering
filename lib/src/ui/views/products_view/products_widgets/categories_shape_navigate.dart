// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_carousel_slider.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_categories_widget.dart';

class CategoriesShapeNavigation extends StatefulWidget {
  CategoriesShapeNavigation(
      {super.key, required this.scrolled, required this.scrollOffset});
  final bool scrolled;
  final double scrollOffset;

  @override
  State<CategoriesShapeNavigation> createState() =>
      _CategoriesShapeNavigationState();
}

class _CategoriesShapeNavigationState extends State<CategoriesShapeNavigation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
          reverseDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500),
          child: CustomCarouselSlider(
              initialPage: productsVieewController.sliderIndex.value,
              aspectRatio: widget.scrolled ? 9.5 : null,
              scrolled: widget.scrolled,
              onPageChanged: (index, reason) {
                // productsVieewController.produtSelected.value = -1;
              },
              itemCount: productsVieewController.isCategoriesShimmerLoader.value
                  ? 1
                  : productsVieewController.carouselItems.length,
              key: Key('${widget.scrolled}'),
              itemBuilder:
                  (BuildContext context, int sliderIndex, int realIndex) {
                return Obx(() {
                  debugPrint(productsVieewController.current.value.toString());
                  return CustomListView(
                    borderRadius: BorderRadius.circular(20),
                    itemCount:
                        productsVieewController.isCategoriesShimmerLoader.value
                            ? 4
                            : productsVieewController
                                .carouselItems[sliderIndex].length,
                    separatorPadding:
                        widget.scrolled ? 0.px : context.screenWidth(20).px,
                    backgroundColor: widget.scrolled &&
                            !productsVieewController
                                .isCategoriesShimmerLoader.value
                        ? Get.theme.colorScheme.primary
                        : Theme.of(context).scaffoldBackgroundColor,
                    itemBuilder: (context, index) {
                      return productsVieewController
                              .isCategoriesShimmerLoader.value
                          ? Obx(
                              () => categoriesShimmer(
                                  scrolled: widget.scrolled,
                                  isLoading: productsVieewController
                                      .isCategoriesShimmerLoader.value),
                            )
                          : CustomCategoriesWidget(
                              onTap: () {
                                productsVieewController.sliderIndex.value =
                                    sliderIndex;
                                productsVieewController.categoryIndex.value =
                                    index;
                                productsVieewController.getProductsByCategory(
                                    id: productsVieewController
                                        .carouselItems[sliderIndex][index].id!);
                              },
                              scrolled: widget.scrolled,
                              fontsize: !widget.scrolled
                                  ? lerpDouble(
                                      AppFonts(context).bodySmall,
                                      10,
                                      (widget.scrollOffset / 10)
                                          .clamp(0.0, 1.0))
                                  : null,
                              index: index,
                              sliderIndex: sliderIndex,
                              scrollOffset: widget.scrollOffset,
                            );
                    },
                  );
                });
              }));
    });
  }
}
