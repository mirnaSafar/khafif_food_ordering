import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_carousel_slider.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_categories_widget.dart';

class CategoriesShapeNavigation extends StatelessWidget {
  const CategoriesShapeNavigation(
      {super.key, required this.scrolled, required this.scrollOffset});
  final bool scrolled;
  final double scrollOffset;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
          // transitionBuilder: (child, animation) {
          //   return ScaleTransition(
          //     scale: animation,
          //     // opacity: animation,
          //     child: child,
          //   );
          // },
          // // switchInCurve: Curves.easeInOutCirc,
          duration: const Duration(milliseconds: 200),
          child: CustomCarouselSlider(
              dotsHeigth:
                  lerpDouble(10, 0, (scrollOffset / 20).clamp(0.0, 1.0)),
              aspectRatio: scrolled
                  ? 9.5
                  : lerpDouble(3, 3.5, (scrollOffset / 2).clamp(0.0, 1.0)),
              scrolled: scrolled,
              onPageChanged: (index, reason) {
                productsVieewController.produtSelected.value = -1;
              },
              itemCount: productsVieewController.isCategoriesShimmerLoader.value
                  ? 1
                  : productsVieewController.carouselItems.length,
              key: Key('$scrolled'),
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
                    separatorPadding: scrolled ? 0.px : screenWidth(20).px,
                    backgroundColor: scrolled &&
                            !productsVieewController
                                .isCategoriesShimmerLoader.value
                        ? AppColors.mainWhiteColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    itemBuilder: (context, index) {
                      return productsVieewController
                              .isCategoriesShimmerLoader.value
                          ? Obx(
                              () => categoriesShimmer(
                                  scrolled: scrolled,
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
                              scrolled: scrolled,
                              fontsize: !scrolled
                                  ? lerpDouble(AppFonts.bodySmall, 10,
                                      (scrollOffset / 10).clamp(0.0, 1.0))
                                  : null,
                              index: index,
                              sliderIndex: sliderIndex,
                              scrollOffset: scrollOffset,
                            );
                    },
                  );
                });
              }));

      //   !scrolled
      //       ? CustomCarouselSlider(
      //           aspectRatio:
      //               lerpDouble(3, 20, (scrollOffset / 100).clamp(0.0, 1.0)),
      //           scrolled: scrolled,
      //           onPageChanged: (index, reason) {
      //             // productsVieewController.produtSelected.value = -1;
      //           },
      //           itemCount:
      //               productsVieewController.isCategoriesShimmerLoader.value
      //                   ? 4
      //                   : productsVieewController.carouselItems.length,
      //           key: Key('$scrolled'),
      //           itemBuilder:
      //               (BuildContext context, int sliderIndex, int realIndex) {
      //             return Obx(
      //               () {
      //                 debugPrint(
      //                     productsVieewController.current.value.toString());
      //                 return CustomListView(
      //                     borderRadius: BorderRadius.circular(20),
      //                     itemCount: productsVieewController
      //                             .isCategoriesShimmerLoader.value
      //                         ? 4
      //                         : productsVieewController
      //                             .carouselItems[sliderIndex].length,
      //                     separatorPadding: screenWidth(20).px,
      //                     backgroundColor:
      //                         Theme.of(context).scaffoldBackgroundColor,
      //                     itemBuilder: (context, index) {
      //                       return productsVieewController
      //                               .isCategoriesShimmerLoader.value
      //                           ? Obx(
      //                               () => categoriesShimmer(
      //                                   scrolled: scrolled,
      //                                   isLoading: productsVieewController
      //                                       .isCategoriesShimmerLoader.value),
      //                             )
      //                           : Padding(
      //                               padding: EdgeInsets.all(screenWidth(200)),
      //                               child: Padding(
      //                                 padding: EdgeInsets.symmetric(
      //                                     horizontal: screenWidth(600),
      //                                     vertical: screenWidth(100)),
      //                                 child: InkWell(
      //                                   onTap: () {
      //                                     productsVieewController
      //                                         .produtSelected.value = index;
      //                                     productsVieewController
      //                                         .changeBackgroundcolor(index);
      //                                     productsVieewController
      //                                         .sliderIndex.value = sliderIndex;
      //                                     productsVieewController
      //                                         .categoryIndex.value = index;
      //                                     productsVieewController
      //                                         .getProductsByCategory(
      //                                             id: productsVieewController
      //                                                 .carouselItems[
      //                                                     sliderIndex][index]
      //                                                 .id!);
      //                                     // productsVieewController.changeItemSize(
      //                                     //     index:  index, itemHeight: 158, itemWidth: 58);
      //                                   },
      //                                   child: CustomContainer(
      //                                     containerStyle:
      //                                         ContainerStyle.CYLINDER,
      //                                     borderRadius:
      //                                         BorderRadius.circular(20),
      //                                     backgroundColor:
      //                                         productsVieewController
      //                                                         .categoryIndex
      //                                                         .value ==
      //                                                     index &&
      //                                                 productsVieewController
      //                                                         .sliderIndex
      //                                                         .value ==
      //                                                     sliderIndex
      //                                             ? AppColors.mainAppColor
      //                                             : AppColors.mainWhiteColor,
      //                                     width: screenWidth(5.5),
      //                                     // height: 115,
      //                                     padding: EdgeInsets.symmetric(
      //                                         vertical: screenWidth(50)),
      //                                     child: Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.start,
      //                                       children: [
      //                                         Flexible(
      //                                           // fit: FlexFit.loose
      //                                           flex: 4,
      //                                           child: CustomContainer(
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       100),
      //                                               height: screenWidth(7),
      //                                               width: screenWidth(7),
      //                                               backgroundColor: AppColors
      //                                                   .mainWhiteColor,
      //                                               // padding: EdgeInsets.all(screenWidth(40)),
      //                                               child: Transform.scale(
      //                                                   scale: 0.7,
      //                                                   child:
      //                                                       CachedNetworkImage(
      //                                                     imageUrl: productsVieewController
      //                                                             .carouselItems[
      //                                                                 sliderIndex]
      //                                                                 [index]
      //                                                             .image ??
      //                                                         '',
      //                                                     errorWidget: (context,
      //                                                         url, error) {
      //                                                       return const Icon(
      //                                                           Icons.error);
      //                                                     },
      //                                                   ))).paddingOnly(
      //                                               bottom: screenWidth(50)),
      //                                         ),
      //                                         // ! eenWidth(50).ph : 0.ph,
      //                                         Flexible(
      //                                           child: CustomText(
      //                                             fontSize: lerpDouble(
      //                                                 AppFonts.bodySmall,
      //                                                 0,
      //                                                 (scrollOffset / 20)
      //                                                     .clamp(0.0, 1.0)),
      //                                             text: productsVieewController
      //                                                     .carouselItems[
      //                                                         sliderIndex]
      //                                                         [index]
      //                                                     .name ??
      //                                                 '',
      //                                             textType:
      //                                                 TextStyleType.CUSTOM,
      //                                             fontWeight: FontWeight.w600,
      //                                             darkTextColor:
      //                                                 AppColors.mainBlackColor,
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             );
      //                     });
      //               },
      //             );
      //           })
      //       : CustomCarouselSlider(
      //           aspectRatio: 9.5,
      //           scrolled: true,
      //           onPageChanged: (index, reason) {
      //             // productsVieewController.produtSelected.value = -1;
      //           },
      //           itemCount:
      //               productsVieewController.isCategoriesShimmerLoader.value
      //                   ? 4
      //                   : productsVieewController.carouselItems.length,
      //           key: Key('$scrolled'),
      //           itemBuilder:
      //               (BuildContext context, int sliderIndex, int realIndex) {
      //             return Obx(
      //               () {
      //                 debugPrint(
      //                     productsVieewController.current.value.toString());
      //                 return CustomListView(
      //                     borderRadius: BorderRadius.circular(20),
      //                     itemCount: productsVieewController
      //                             .isCategoriesShimmerLoader.value
      //                         ? 4
      //                         : productsVieewController
      //                             .carouselItems[sliderIndex].length,
      //                     separatorPadding: 0.px,
      //                     backgroundColor: !productsVieewController
      //                             .isCategoriesShimmerLoader.value
      //                         ? AppColors.mainWhiteColor
      //                         : Theme.of(context).scaffoldBackgroundColor,
      //                     itemBuilder: (context, index) {
      //                       return productsVieewController
      //                               .isCategoriesShimmerLoader.value
      //                           ? Obx(
      //                               () => categoriesShimmer(
      //                                   scrolled: true,
      //                                   isLoading: productsVieewController
      //                                       .isCategoriesShimmerLoader.value),
      //                             )
      //                           : Padding(
      //                               padding: const EdgeInsets.all(0),
      //                               child: Padding(
      //                                 padding: EdgeInsets.symmetric(
      //                                     horizontal: screenWidth(600),
      //                                     vertical: screenWidth(100)),
      //                                 child: InkWell(
      //                                   onTap: () {
      //                                     productsVieewController
      //                                         .produtSelected.value = index;
      //                                     productsVieewController
      //                                         .changeBackgroundcolor(index);

      //                                     productsVieewController
      //                                         .sliderIndex.value = sliderIndex;
      //                                     productsVieewController
      //                                         .categoryIndex.value = index;
      //                                     productsVieewController
      //                                         .getProductsByCategory(
      //                                             id: productsVieewController
      //                                                 .carouselItems[
      //                                                     sliderIndex][index]
      //                                                 .id!);

      //                                     //productsVieewController.changeItemSize(
      //                                     //     index: index, itemHeight: 158, itemWidth: 58);
      //                                   },
      //                                   child: CustomContainer(
      //                                     borderRadius:
      //                                         BorderRadius.circular(20),
      //                                     backgroundColor:
      //                                         productsVieewController
      //                                                         .categoryIndex
      //                                                         .value ==
      //                                                     index &&
      //                                                 productsVieewController
      //                                                         .sliderIndex
      //                                                         .value ==
      //                                                     sliderIndex
      //                                             ? AppColors.mainAppColor
      //                                             : AppColors.mainWhiteColor,
      //                                     width: screenWidth(4.5),
      //                                     // height: 115,

      //                                     child: Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.center,
      //                                       children: [
      //                                         Flexible(
      //                                           child: CustomText(
      //                                             text: productsVieewController
      //                                                     .carouselItems[
      //                                                         sliderIndex]
      //                                                         [index]
      //                                                     .name ??
      //                                                 '',
      //                                             textType:
      //                                                 TextStyleType.BODYSMALL,
      //                                             fontWeight: FontWeight.w600,
      //                                             darkTextColor:
      //                                                 AppColors.mainBlackColor,
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             );
      //                     });
      //               },
      //             );
      //           }),
      // );

      // return AnimatedCrossFade(
      //   layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
      //     return Stack(
      //       alignment: Alignment.center,
      //       clipBehavior: Clip.none,
      //       children: [
      //         Positioned(
      //           key: bottomChildKey,
      //           bottom: 0,
      //           child: bottomChild,
      //         ),
      //         Positioned(
      //           key: topChildKey,
      //           child: topChild,
      //         )
      //       ],
      //     );
      //   },
      // firstChild: Visibility(
      //   // visible: scrollOffset < 10,
      //   child: CustomCarouselSlider(
      //       aspectRatio:
      //           lerpDouble(3, 20, (scrollOffset / 100).clamp(0.0, 1.0)),
      //       scrolled: scrolled,
      //       onPageChanged: (index, reason) {
      //         // productsVieewController.produtSelected.value = -1;
      //       },
      //       itemCount: productsVieewController.isCategoriesShimmerLoader.value
      //           ? 4
      //           : productsVieewController.carouselItems.length,
      //       // key: Key('$scrolled'),
      //       itemBuilder:
      //           (BuildContext context, int sliderIndex, int realIndex) {
      //         return Obx(
      //           () {
      //             debugPrint(
      //                 productsVieewController.current.value.toString());
      //             return CustomListView(
      //                 borderRadius: BorderRadius.circular(20),
      //                 itemCount: productsVieewController
      //                         .isCategoriesShimmerLoader.value
      //                     ? 4
      //                     : productsVieewController
      //                         .carouselItems[sliderIndex].length,
      //                 separatorPadding: screenWidth(20).px,
      //                 backgroundColor:
      //                     Theme.of(context).scaffoldBackgroundColor,
      //                 itemBuilder: (context, index) {
      //                   return productsVieewController
      //                           .isCategoriesShimmerLoader.value
      //                       ? Obx(
      //                           () => categoriesShimmer(
      //                               scrolled: scrolled,
      //                               isLoading: productsVieewController
      //                                   .isCategoriesShimmerLoader.value),
      //                         )
      //                       : Padding(
      //                           padding: EdgeInsets.all(screenWidth(200)),
      //                           child: Padding(
      //                             padding: EdgeInsets.symmetric(
      //                                 horizontal: screenWidth(600),
      //                                 vertical: screenWidth(100)),
      //                             child: InkWell(
      //                               onTap: () {
      //                                 productsVieewController
      //                                     .produtSelected.value = index;
      //                                 productsVieewController
      //                                     .changeBackgroundcolor(index);
      //                                 productsVieewController
      //                                     .sliderIndex.value = sliderIndex;
      //                                 productsVieewController
      //                                     .categoryIndex.value = index;
      //                                 productsVieewController
      //                                     .getProductsByCategory(
      //                                         id: productsVieewController
      //                                             .carouselItems[sliderIndex]
      //                                                 [index]
      //                                             .id!);
      //                                 // productsVieewController.changeItemSize(
      //                                 //     index:  index, itemHeight: 158, itemWidth: 58);
      //                               },
      //                               child: CustomContainer(
      //                                 containerStyle: ContainerStyle.CYLINDER,
      //                                 borderRadius: BorderRadius.circular(20),
      //                                 backgroundColor: productsVieewController
      //                                                 .categoryIndex.value ==
      //                                             index &&
      //                                         productsVieewController
      //                                                 .sliderIndex.value ==
      //                                             sliderIndex
      //                                     ? AppColors.mainAppColor
      //                                     : AppColors.mainWhiteColor,
      //                                 width: screenWidth(5.5),
      //                                 // height: 115,
      //                                 padding: EdgeInsets.symmetric(
      //                                     vertical: screenWidth(50)),
      //                                 child: Column(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   children: [
      //                                     Flexible(
      //                                       // fit: FlexFit.loose
      //                                       flex: 4,
      //                                       child: CustomContainer(
      //                                           borderRadius:
      //                                               BorderRadius.circular(
      //                                                   100),
      //                                           height: screenWidth(7),
      //                                           width: screenWidth(7),
      //                                           backgroundColor:
      //                                               AppColors.mainWhiteColor,
      //                                           // padding: EdgeInsets.all(screenWidth(40)),
      //                                           child: Transform.scale(
      //                                               scale: 0.7,
      //                                               child: CachedNetworkImage(
      //                                                 imageUrl: productsVieewController
      //                                                         .carouselItems[
      //                                                             sliderIndex]
      //                                                             [index]
      //                                                         .image ??
      //                                                     '',
      //                                                 errorWidget: (context,
      //                                                     url, error) {
      //                                                   return const Icon(
      //                                                       Icons.error);
      //                                                 },
      //                                               ))).paddingOnly(
      //                                           bottom: screenWidth(50)),
      //                                     ),
      //                                     // ! eenWidth(50).ph : 0.ph,
      //                                     Flexible(
      //                                       child: CustomText(
      //                                         fontSize: lerpDouble(
      //                                             AppFonts.bodySmall,
      //                                             0,
      //                                             (scrollOffset / 20)
      //                                                 .clamp(0.0, 1.0)),
      //                                         text: productsVieewController
      //                                                 .carouselItems[
      //                                                     sliderIndex][index]
      //                                                 .name ??
      //                                             '',
      //                                         textType: TextStyleType.CUSTOM,
      //                                         fontWeight: FontWeight.w600,
      //                                         darkTextColor:
      //                                             AppColors.mainBlackColor,
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         );
      //                 });
      //           },
      //         );
      //       }),
      // ),
      // secondChild: CustomCarouselSlider(
      //     aspectRatio: 9.5,
      //     scrolled: true,
      //     onPageChanged: (index, reason) {
      //       // productsVieewController.produtSelected.value = -1;
      //     },
      //     itemCount: productsVieewController.isCategoriesShimmerLoader.value
      //         ? 4
      //         : productsVieewController.carouselItems.length,
      //     // key: Key('$scrolled'),
      //     itemBuilder:
      //         (BuildContext context, int sliderIndex, int realIndex) {
      //       return Obx(
      //         () {
      //           debugPrint(productsVieewController.current.value.toString());
      //           return CustomListView(
      //               borderRadius: BorderRadius.circular(20),
      //               itemCount: productsVieewController
      //                       .isCategoriesShimmerLoader.value
      //                   ? 4
      //                   : productsVieewController
      //                       .carouselItems[sliderIndex].length,
      //               separatorPadding: 0.px,
      //               backgroundColor: !productsVieewController
      //                       .isCategoriesShimmerLoader.value
      //                   ? AppColors.mainWhiteColor
      //                   : Theme.of(context).scaffoldBackgroundColor,
      //               itemBuilder: (context, index) {
      //                 return productsVieewController
      //                         .isCategoriesShimmerLoader.value
      //                     ? Obx(
      //                         () => categoriesShimmer(
      //                             scrolled: true,
      //                             isLoading: productsVieewController
      //                                 .isCategoriesShimmerLoader.value),
      //                       )
      //                     : Padding(
      //                         padding: const EdgeInsets.all(0),
      //                         child: Padding(
      //                           padding: EdgeInsets.symmetric(
      //                               horizontal: screenWidth(600),
      //                               vertical: screenWidth(100)),
      //                           child: InkWell(
      //                             onTap: () {
      //                               productsVieewController
      //                                   .produtSelected.value = index;
      //                               productsVieewController
      //                                   .changeBackgroundcolor(index);

      //                               productsVieewController
      //                                   .sliderIndex.value = sliderIndex;
      //                               productsVieewController
      //                                   .categoryIndex.value = index;
      //                               productsVieewController
      //                                   .getProductsByCategory(
      //                                       id: productsVieewController
      //                                           .carouselItems[sliderIndex]
      //                                               [index]
      //                                           .id!);

      //                               //productsVieewController.changeItemSize(
      //                               //     index: index, itemHeight: 158, itemWidth: 58);
      //                             },
      //                             child: CustomContainer(
      //                               borderRadius: BorderRadius.circular(20),
      //                               backgroundColor: productsVieewController
      //                                               .categoryIndex.value ==
      //                                           index &&
      //                                       productsVieewController
      //                                               .sliderIndex.value ==
      //                                           sliderIndex
      //                                   ? AppColors.mainAppColor
      //                                   : AppColors.mainWhiteColor,
      //                               width: screenWidth(4.5),
      //                               // height: 115,

      //                               child: Column(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.center,
      //                                 children: [
      //                                   Flexible(
      //                                     child: CustomText(
      //                                       text: productsVieewController
      //                                               .carouselItems[
      //                                                   sliderIndex][index]
      //                                               .name ??
      //                                           '',
      //                                       textType: TextStyleType.BODYSMALL,
      //                                       fontWeight: FontWeight.w600,
      //                                       darkTextColor:
      //                                           AppColors.mainBlackColor,
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       );
      //               });
      //         },
      //       );
      //     }),
      //   alignment: Alignment.center,
      //   firstCurve: Curves.easeIn,
      //   secondCurve: Curves.slowMiddle,
      //   excludeBottomFocus: false,
      //   reverseDuration: const Duration(milliseconds: 200),
      //   crossFadeState:
      //       scrolled ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      //   duration: const Duration(milliseconds: 500),
      // );
    });
  }
}

// AnimatedScale(
//                                                 scale: 1,
//                                                 // scrolled
//                                                 //     ? 1 - scaleFactor
//                                                 //     : scaleFactor,
//                                                 duration: const Duration(
//                                                     milliseconds: 100),
//                                                 child: CustomCarouselSlider(
//                                                   aspectRatio: scrolled
//                                                       ? 9.5
//                                                       : lerpDouble(
//                                                           3,
//                                                           20,
//                                                           ( scrollOffset /
//                                                                   100)
//                                                               .clamp(0.0, 1.0)),
//                                                   scrolled: scrolled,
//                                                   onPageChanged:
//                                                       (index, reason) {
//                                                   //                                                   productsVieewController.produtSelected
//                                                         .value = -1;
//                                                   },
//                                                   itemCount: productsVieewController
//                                                           .isCategoriesShimmerLoader
//                                                           .value
//                                                       ? 4
//                                                       : productsVieewController
//                                                           .carouselItems.length,
//                                                   key: Key('$scrolled'),
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int sliderIndex,
//                                                           int realIndex) {
//                                                     return Obx(() {
//                                                       debugPrint(productsVieewController
//                                                           .current.value
//                                                           .toString());
//                                                       return CustomListView(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20),
//                                                         itemCount: productsVieewController
//                                                                 .isCategoriesShimmerLoader
//                                                                 .value
//                                                             ? 5
//                                                             : productsVieewController
//                                                                 .carouselItems[
//                                                                     sliderIndex]
//                                                                 .length,
//                                                         separatorPadding:
//                                                             scrolled
//                                                                 ? 0.px
//                                                                 : screenWidth(
//                                                                         20)
//                                                                     .px,
//                                                         backgroundColor: scrolled &&
//                                                                 !productsVieewController
//                                                                     .isCategoriesShimmerLoader
//                                                                     .value
//                                                             ? AppColors
//                                                                 .mainWhiteColor
//                                                             : Theme.of(context)
//                                                                 .scaffoldBackgroundColor,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           return productsVieewController
//                                                                   .isCategoriesShimmerLoader
//                                                                   .value
//                                                               ? Obx(
//                                                                   () => categoriesShimmer(
//                                                                       scrolled:
//                                                                           scrolled,
//                                                                       isLoading: productsVieewController
//                                                                           .isCategoriesShimmerLoader
//                                                                           .value),
//                                                                 )
//                                                               : CustomListViewItem(
//                                                                   onTap: () {
//                                                                     productsVieewController
//                                                                             .sliderIndex
//                                                                             .value =
//                                                                         sliderIndex;
//                                                                     productsVieewController
//                                                                         .categoryIndex
//                                                                         .value = index;
//                                                                   //                                                                   productsVieewControllergetProductsByCategory(.getProductsByCategory(
//                                                                         id: productsVieewController
//                                                                             .carouselItems[sliderIndex][index]
//                                                                             .id!);
//                                                                   },
//                                                                   scrolled:
//                                                                       scrolled,
//                                                                   fontsize: !scrolled
//                                                                       ? lerpDouble(
//                                                                           AppFonts
//                                                                               .bodySmall,
//                                                                           0,
//                                                                           ( scrollOffset / 20).clamp(
//                                                                               0.0,
//                                                                               1.0))
//                                                                       : null,
//                                                                   index: index,
//                                                                   sliderIndex:
//                                                                       sliderIndex,
//                                                                 );
//                                                         },
//                                                       );
//                                                     });
//                                                   },
//                                                 ),
//                                               )
