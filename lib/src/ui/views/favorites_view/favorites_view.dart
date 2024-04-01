import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/views/favorites_view/favorites_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_favorite.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_name_calories.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_price_currency.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_image.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoritesController controller = Get.put(FavoritesController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppbar(appbarTitle: 'favorites'),
      body: Obx(() {
        return controller.favoritesList.isEmpty
            ? const Center(child: Text('No Favorites yet'))
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
                            CustomFavorite(
                                product: controller.favoritesList[index]),
                            Column(
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
                                                  .favoritesList[index].name ??
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
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
      }),
    ));
  }
}
