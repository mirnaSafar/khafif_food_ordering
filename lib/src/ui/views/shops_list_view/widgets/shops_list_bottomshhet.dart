import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/branch_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shop_bottomsheet.dart';

class ShopsListBottomSheet extends StatelessWidget {
  const ShopsListBottomSheet(this.shopsList,
      {super.key, this.scrollController});
  final List<BranchModel> shopsList;
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    ShopsController controller = Get.put(ShopsController());

    return Obx(() {
      print(controller.isShopsLoading.value);
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // screenWidth(20).ph,
          InkWell(
            onTap: () => controller.panelController.isPanelClosed
                ? controller.panelController.open()
                : controller.panelController.close(),
            child: Container(
              width: screenWidth(10),
              height: screenWidth(100),
              color: AppColors.mainAppColor,
            ).paddingSymmetric(vertical: screenWidth(40)),
          ),
          screenWidth(40).ph,
          Expanded(
            child: CustomListView(
              controller: scrollController,
              itemCount: shopsList.length,
              separatorPadding: 10.ph,
              vertical: true,
              backgroundColor: AppColors.mainBlackColor,
              listViewHeight: screenHeight(1.8),
              itemBuilder: (listcontext, index) => InkWell(
                onTap: () {
                  Get.back();

                  Get.delete<MapController>();

                  Get.to(MapPage(
                    sourceLocation: LatLng(
                      shopsList[index].latitude!,
                      shopsList[index].longitude!,
                    ),
                    openPanelHeight: screenHeight(2),
                    closePanelHeight: screenHeight(3),
                    bottomsheet: ShopBottomSheet(
                      shop: shopsList[index],
                      shops: shopsList,
                    ),
                    appBarTitle: tr('shops_lb'),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(200)),
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: shopsList[index].image ?? '',
                        height: screenWidth(4),
                        width: screenWidth(4),
                      ),
                      // screenWidth(50).px,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            darkTextColor: AppColors.mainBlackColor,
                            text: shopsList[index].name ?? "",
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.mainTextColor,
                            textType: TextStyleType.BODY,
                          ),
                          CustomText(
                            darkTextColor: AppColors.mainBlackColor,
                            text:
                                '${shopsList[index].city} - 2.5 km .15 min walk',
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.greyTextColor,
                            textType: TextStyleType.SMALL,
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.icClock,
                                height: screenWidth(35),
                                width: screenWidth(35),
                              ),
                              screenWidth(100).px,
                              CustomText(
                                  darkTextColor: AppColors.mainBlackColor,
                                  text: 'Opening time: ',
                                  fontWeight: FontWeight.w500,
                                  textType: TextStyleType.SMALL),
                              CustomText(
                                  darkTextColor: AppColors.mainBlackColor,
                                  text:
                                      '${shopsList[index].workTimeFrom}AM - ${shopsList[index].workTimeTo}AM',
                                  fontWeight: FontWeight.w500,
                                  textType: TextStyleType.SMALL)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
