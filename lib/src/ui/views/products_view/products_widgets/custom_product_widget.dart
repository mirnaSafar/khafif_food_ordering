// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_favorite.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_name_calories.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_price_currency.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';

class CustomProductWidget extends StatelessWidget {
  CustomProductWidget({super.key, required this.product});
  final ProductTemplateModel product;

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = (-1).obs;

    return CustomContainer(
      blurRadius: 4,
      shadowColor: AppColors.shadowColor,
      offset: const Offset(0, 4),
      containerStyle: ContainerStyle.BIGSQUARE,
      borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth(50),
          vertical: context.screenWidth(90)),
      width: context.screenWidth(2.3),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          InkWell(
            onTap: () {
              selectedIndex.value =
                  productsVieewController.productsList.indexOf(product);
              Get.to(
                ProductDetailsView(
                  product: product,
                ),
                duration: const Duration(seconds: 0),
                transition: Transition.noTransition,
              );
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Center(
                      child: CustomNetworkImage(
                        imageUrl: product.image ?? '',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomNameCalories(
                          productname: product.name ?? '',
                          calory: product.calories.toString()),
                      CustomPriceCurrency(price: product.price.toString()),
                    ],
                  )
                ]),
          ),
          CustomFavorite(
            index: productsVieewController.productsList.indexOf(product),
            product: product,
          ),
        ],
      ),
    );
  }
}
