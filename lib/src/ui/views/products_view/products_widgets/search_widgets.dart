// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_widget.dart';

searchResultsView() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Get.context!.screenWidth(10)),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Get.context!.screenWidth(20),
      ),
      itemCount: productsVieewController.searchProductsList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.context!.screenWidth(80)),
              child: productsVieewController.isShimmerLoader.value
                  ? productsShimmer(isLoading: true)
                  : CustomProductWidget(
                      product:
                          productsVieewController.searchProductsList[index],
                    )),
        );
      },
    ),
  );
}

buildSearchField() {
  double rightRadius =
      storage.getAppLanguage() == LanguageService.enCode ? 0 : 8;
  double leftRadius =
      storage.getAppLanguage() == LanguageService.enCode ? 8 : 0;
  return Expanded(
    child: UserInput(
        fillColor: Get.theme.colorScheme.primary,
        height: Get.context!.screenWidth(9),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(rightRadius),
          bottomRight: Radius.circular(rightRadius),
          topLeft: Radius.circular(leftRadius),
          bottomLeft: Radius.circular(leftRadius),
        ),
        prefixIcon: Transform.scale(
          scale: 0.4,
          child: SvgPicture.asset(
            color: Get.theme.colorScheme.secondary,
            AppAssets.icSearch,
          ),
        ),
        onChange: (query) {
          query.isNotEmpty
              ? productsVieewController.searchProducts(query: query)
              : getCurrentProducts();
          query.isEmpty
              ? productsVieewController.searchProductsList.clear()
              : null;
        },
        onSubmitted: (query) {
          query.isNotEmpty
              ? productsVieewController.searchProducts(query: query)
              : getCurrentProducts();
        },
        text: tr('search_lb'),
        controller: productsVieewController.searchController),
  );
}

class NoSearchResultsWidget extends StatelessWidget {
  const NoSearchResultsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment:
        //     CrossAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: Get.context!.screenWidth(6)),
          Padding(
              padding: EdgeInsets.only(top: Get.context!.screenWidth(900)),
              child: CustomText(
                  text: tr('no_matched_results_lb'),
                  textType: TextStyleType.TITLE)),
          Get.context!.screenWidth(30).ph,
        ],
      ),
    );
  }
}

buildFilterWidget() {
  return CustomContainer(
    backgroundColor: Get.theme.colorScheme.primary,
    height: Get.context!.screenHeight(18),
    width: Get.context!.screenHeight(15),
    borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(8), bottomEnd: Radius.circular(8)),
    padding: EdgeInsets.all(
      Get.context!.screenWidth(28),
    ),
    child: SvgPicture.asset(
      color: Get.theme.colorScheme.secondary,
      AppAssets.icFilter,
      height: Get.context!.screenWidth(80),
      width: Get.context!.screenWidth(80),
    ),
  );
}
