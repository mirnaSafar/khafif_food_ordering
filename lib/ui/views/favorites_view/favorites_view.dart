import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/views/favorites_view/favorites_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_favorite.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_name_calories.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_price_currency.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoritesController controller = Get.put(FavoritesController());
  RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appbarTitle: tr('favorites_lb')),
      body: Obx(() {
        return controller.favoritesList.isEmpty
            ? Center(child: Text(tr('no_favorites_lb')))
            : GridView.builder(
                shrinkWrap: true,
                itemCount: controller.favoritesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: screenWidth(30)),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomContainer(
                        blurRadius: 4,
                        shadowColor: AppColors.shadowColor,
                        borderRadius: BorderRadius.circular(12),

                        offset: const Offset(0, 4),
                        containerStyle: ContainerStyle.BIGSQUARE,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(50),
                            vertical: screenWidth(90)),
                        // borderRadius: 19,
                        // height: 207,
                        width: screenWidth(2.3),

                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ProductDetailsView(
                                    product: controller.favoritesList[index]));
                              },
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      // height:
                                      //     screenWidth(20),

                                      child: CustomNetworkImage(
                                        imageUrl: controller
                                                .favoritesList[index].image ??
                                            '',
                                      ),
                                    ),

                                    //  SvgPicture.asset(e.values.first[0]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomNameCalories(
                                            productname: controller
                                                    .favoritesList[index]
                                                    .name ??
                                                '',
                                            calory: controller
                                                .favoritesList[index].calories
                                                .toString()),
                                        CustomPriceCurrency(
                                            price: controller
                                                .favoritesList[index].price
                                                .toString()),
                                      ],
                                    )
                                  ]),
                            ),
                            InkWell(
                              onTap: () => selectedIndex.value = index,
                              child: CustomFavorite(
                                  index: selectedIndex.value,
                                  product: controller.favoritesList[index]),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
      }),
    );
  }
}
