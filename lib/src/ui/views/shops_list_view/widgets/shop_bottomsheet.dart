// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/branch_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';

class ShopBottomSheet extends StatefulWidget {
  ShopBottomSheet({super.key, required this.shop, required this.shops});
  final BranchModel shop;
  final List<BranchModel> shops;
  @override
  State<ShopBottomSheet> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShopBottomSheet> {
  @override
  Widget build(BuildContext context) {
    ShopsController controller = Get.put(ShopsController());
    MapController mapController =
        Get.put(MapController(destination: storage.userCurrentLocation!));

    return Obx(
      () {
        print(controller.isShopsLoading);

        return PopScope(
          onPopInvoked: (didPop) {
            Get.delete<MapController>();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: context.screenWidth(8),
                  height: context.screenWidth(100),
                  color: AppColors.mainAppColor,
                ),
                context.screenWidth(13).ph,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth(200)),
                  child: DefaultTextStyle(
                    style: const TextStyle(),
                    child: SizedBox(
                      // width:  context .screenWidth(8),
                      height: context.screenWidth(2),
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        padEnds: false,
                        onPageChanged: (index) {
                          LatLng sourceLocation = LatLng(
                              widget.shops[index].latitude!,
                              widget.shops[index].longitude!);

                          mapController
                              .changeCameraPosition(newLocation: sourceLocation)
                              .then((value) {
                            mapController.addtoMarkers('Source', sourceLocation,
                                locationDesc: widget.shops[index].name);
                            setState(() {});
                          });
                          mapController.update();
                          // Get.forceAppUpdate();
                          // Get.reloa

                          // controller.currentPage.value = index;
                        },
                        controller: PageController(
                            initialPage: widget.shops.indexOf(widget.shop)),
                        itemCount: widget.shops.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: widget.shops[index].image ?? '',
                                      height: context.screenWidth(4),
                                      width: context.screenWidth(4),
                                    ),
                                    //  context .screenWidth(50).px,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          darkTextColor:
                                              AppColors.mainBlackColor,
                                          text: widget.shops[index].name ?? '',
                                          fontWeight: FontWeight.w700,
                                          textColor: AppColors.mainTextColor,
                                          textType: TextStyleType.TITLE,
                                        ),
                                        context
                                            .screenWidth(30)
                                            .ph, // CustomText(
                                        //   darkTextColor:
                                        //       AppColors.mainBlackColor,
                                        //   text:
                                        //       '${widget.shops[index].city} - 2.5 km .15 min walk',
                                        //   fontWeight: FontWeight.w400,
                                        //   textColor: AppColors.greyTextColor,
                                        //   textType: TextStyleType.BODYSMALL,
                                        // ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.icClock,
                                              height: context.screenWidth(17),
                                              width: context.screenWidth(17),
                                            ).paddingOnly(top: 6),
                                            context.screenWidth(100).px,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    darkTextColor: AppColors
                                                        .mainBlackColor,
                                                    text:
                                                        '${tr('opening_time_lb')} ',
                                                    fontWeight: FontWeight.w600,
                                                    textType:
                                                        TextStyleType.BODY),
                                                CustomText(
                                                    darkTextColor: AppColors
                                                        .mainBlackColor,
                                                    text: widget.shops[index]
                                                                .workTimeTo ==
                                                            null
                                                        ? ''
                                                        : '(${dateTimeController.parse24TimeTo12(timeIn24: widget.shops[index].workTimeFrom!)}) - (${dateTimeController.parse24TimeTo12(timeIn24: widget.shops[index].workTimeTo!)})',
                                                    fontWeight: FontWeight.w600,
                                                    textType:
                                                        TextStyleType.BODY),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                CustomButton(
                                  onPressed: () {
                                    controller.setShop(
                                        branchID: widget.shops[index].id!);
                                    // context
                                    //     .pushRepalceme( ProductsView())
                                    //     .then((value) => context.pop());
                                  },
                                  loader: controller.isSetShopLoading.value,
                                  text: tr('order_now_lb'),
                                  height: context.screenWidth(8),
                                ).paddingSymmetric(horizontal: 30, vertical: 10)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// Widget shopBottomSheet({required BranchModel shop}) => 