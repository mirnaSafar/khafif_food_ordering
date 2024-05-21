import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custum_rich_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/shops_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/custom_branch_option.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shop_bottomsheet.dart';

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
    Get.put(ShopsController());
    return Scaffold(
      appBar: CustomAppbar(
        appbarTitle: tr('shops_lb'),
      ),
      body: Obx(() {
        print(shopsController.isShopsLoading);
        return Padding(
            padding: EdgeInsets.only(
              top: context.screenWidth(30),
              bottom: context.screenWidth(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomBranchOption(
                          onTap: () {
                            shopsController.getOpenNowBranches();
                          },
                          displayOptionText: tr('open_now_lb'),
                          index: 0),
                      context.screenWidth(13).px,
                      CustomBranchOption(
                        onTap: () {
                          // shopsController.addAllBranchesMarkerToMap();
                          shopsController.getAll();
                        },
                        displayOptionText: tr('all_branches_lb'),
                        index: 1,
                      ),
                      context.screenWidth(13).px,
                      CustomBranchOption(
                          onTap: () {
                            dateTimeController.selectDate(context);
                          },
                          displayOptionText: tr('schedule_order_lb'),
                          index: 2),
                    ],
                  ).paddingSymmetric(
                    horizontal: context.screenWidth(40),
                  ),
                ),
                context.screenWidth(13).ph,
                // CustomText(
                //         text: 'Order Date: ${dateTimeController.selectedDate}',
                //         textType: TextStyleType.BODY)
                //     .paddingSymmetric(
                //   horizontal: context.screenWidth(40),
                // ),
                CustomRichText(
                  firstText: tr('order_date_lb'),
                  secondText: dateTimeController.formatDateTimeIn24(
                      dateTimeController.selectedTime.value),
                ).paddingSymmetric(
                  horizontal: context.screenWidth(40),
                ),
                context.screenWidth(13).ph,
                shopsController.isShopsLoading.value
                    ? shopsShimmer(
                        isLoading: shopsController.isShopsLoading.value)
                    : shopsController.shopsList.isEmpty
                        ? Center(
                            child: Padding(
                            padding: EdgeInsets.all(context.screenWidth(30)),
                            child: CustomText(
                                text: tr('shedule_order_warning_lb'),
                                textType: TextStyleType.BODY),
                          ))
                        : Expanded(
                            child: CustomListView(
                              itemCount: shopsController.shopsList.length,
                              vertical: true,
                              // listViewHeight: context.screenHeight(1.43),
                              // backgroundColor: AppColors.mainAppColor,
                              separatorPadding: context.screenWidth(20).ph,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  shopsController.checkIfTheBrachOpenORClose(
                                          shopsController.shopsList[index])
                                      ? Get.to(MapPage(
                                          showAllbranchesButton: true,
                                          sourceLocation: LatLng(
                                            shopsController
                                                .shopsList[index].latitude!,
                                            shopsController
                                                .shopsList[index].longitude!,
                                          ),
                                          bottomsheet: ShopBottomSheet(
                                            shop: shopsController
                                                .shopsList[index],
                                            shops: shopsController.shopsList,
                                          ),
                                          appBarTitle: tr('shops_lb'),
                                        ))
                                      : null;
                                },
                                child: CustomContainer(
                                        backgroundColor: shopsController
                                                .checkIfTheBrachOpenORClose(
                                                    shopsController
                                                        .shopsList[index])
                                            ? Colors.white
                                            : Colors.grey[200],
                                        shadowColor: AppColors.shadowColor,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                        borderRadius: BorderRadius.circular(5),
                                        padding:
                                            EdgeInsets
                                                .symmetric(
                                                    vertical: context
                                                        .screenWidth(20),
                                                    horizontal: context
                                                        .screenWidth(30)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: CustomText(
                                                textAlign: TextAlign.start,
                                                darkTextColor:
                                                    AppColors.mainBlackColor,

                                                text: shopsController
                                                        .shopsList[index]
                                                        .name ??
                                                    '',

                                                textType: TextStyleType.BODY,
                                                fontWeight: FontWeight.w600,
                                                // textColor: AppColors.placeholderTextColor,
                                              ),
                                            ),
                                            context.screenWidth(20).px,
                                            Row(
                                              children: [
                                                CustomText(
                                                    darkTextColor: shopsController
                                                            .checkIfTheBrachOpenORClose(
                                                                shopsController
                                                                        .shopsList[
                                                                    index])
                                                        ? Colors.green
                                                        : Colors.red,
                                                    textColor: shopsController
                                                            .checkIfTheBrachOpenORClose(
                                                                shopsController
                                                                        .shopsList[
                                                                    index])
                                                        ? Colors.green
                                                        : Colors.red,
                                                    text:
                                                        '(${shopsController.checkIfTheBrachOpenORClose(shopsController.shopsList[index]) ? tr('open_lb') : tr('close_lb')})',
                                                    textType:
                                                        TextStyleType.SMALL),
                                                SvgPicture.asset(
                                                    AppAssets.icLocation),
                                                CustomText(
                                                  darkTextColor:
                                                      AppColors.mainBlackColor,
                                                  text:
                                                      '${shopsController.calcShopDistanceFromCurrentLocation(shopsController.shopsList[index])} km',
                                                  textType:
                                                      TextStyleType.BODYSMALL,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                    .paddingSymmetric(
                                        horizontal: context.screenWidth(30)),
                              ),
                            ),
                          ),
              ],
            ));
      }),
    );
  }
}
