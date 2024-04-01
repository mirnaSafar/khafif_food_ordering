import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/no_connection_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/shops_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/custom_branch_option.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shop_bottomsheet.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shops_list_bottomshhet.dart';

class ShopsListView extends StatefulWidget {
  const ShopsListView({super.key});

  @override
  State<ShopsListView> createState() => _ShopsListViewState();
}

class _ShopsListViewState extends State<ShopsListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dateTimeController.selectDate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ShopsController controller = Get.put(ShopsController());

    return SafeArea(
        child: Scaffold(
      appBar: CustomAppbar(
        appbarTitle: tr('shops_lb'),
        action: const Row(
          children: [
            // InkWell(
            //     onTap: () {
            //       controller.addAllBranchesMarkerToMap();
            //     },
            //     child: const Icon(Icons.location_on)),
            // InkWell(
            //     onTap: () {
            //       dateTimeController.selectDate(context);
            //     },
            //     child: const Icon(Icons.date_range_outlined)),
          ],
        ),
      ),
      body: Obx(() {
        print(controller.isShopsLoading);
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth(30),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomBranchOption(
                        onTap: () {
                          controller.getOpenNowBranches();
                        },
                        displayOptionText: 'Open now',
                        index: 0),
                    screenWidth(13).px,
                    CustomBranchOption(
                      onTap: () {
                        controller.addAllBranchesMarkerToMap();
                        // controller.getAll();
                      },
                      displayOptionText: 'All branches',
                      index: 1,
                    ),
                    screenWidth(13).px,
                    CustomBranchOption(
                        onTap: () {
                          dateTimeController.selectDate(context);
                        },
                        displayOptionText: 'Schedule order',
                        index: 2),
                  ],
                ).paddingSymmetric(
                  horizontal: screenWidth(40),
                ),
              ),
              screenWidth(13).ph,
              controller.isShopsLoading.value
                  ? shopsShimmer(isLoading: controller.isShopsLoading.value)
                  : controller.shopsList.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                              text:
                                  'Please Schedule Your Order Time First to See Our Available Branches',
                              textType: TextStyleType.BODY),
                        ))
                      : Expanded(
                          child: CustomListView(
                            itemCount: controller.shopsList.length,
                            vertical: true,
                            listViewHeight: screenHeight(1),
                            separatorPadding: screenWidth(20).ph,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Get.to(MapPage(
                                  sourceLocation: LatLng(
                                    controller.shopsList[index].latitude!,
                                    controller.shopsList[index].longitude!,
                                  ),
                                  bottomsheet: ShopBottomSheet(
                                    shop: controller.shopsList[index],
                                    shops: controller.shopsList,
                                  ),
                                  appBarTitle: tr('shops_lb'),
                                ));
                              },
                              child: CustomContainer(
                                      backgroundColor: Colors.white,
                                      shadowColor: AppColors.shadowColor,
                                      blurRadius: 4,
                                      offset: const Offset(0, 4),
                                      borderRadius: BorderRadius.circular(5),
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenWidth(20),
                                          horizontal: screenWidth(30)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            darkTextColor:
                                                AppColors.mainBlackColor,

                                            text: controller
                                                    .shopsList[index].name ??
                                                '',

                                            textType: TextStyleType.BODY,
                                            fontWeight: FontWeight.w600,
                                            // textColor: AppColors.placeholderTextColor,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppAssets.icLocation),
                                              CustomText(
                                                darkTextColor:
                                                    AppColors.mainBlackColor,
                                                text: '20 km',
                                                textType:
                                                    TextStyleType.BODYSMALL,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                  .paddingSymmetric(
                                      horizontal: screenWidth(30)),
                            ),
                          ),
                        ),
            ],
          ),
        );
      }),
    ));
  }
}
