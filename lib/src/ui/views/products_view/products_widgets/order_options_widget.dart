import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/services/location_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_popup_with_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_radio.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_list.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';

void showOrderOptionsDialog(BuildContext context) {
  SplashController splashController = Get.put(SplashController());
  Get.find<SplashController>().orderDeliveryOptions.isEmpty
      ? Get.find<SplashController>().getOrderDeliveryOptions()
      : null;

  Widget buildOption(String text, int value, void Function()? onTap) {
    return Obx(() {
      print(productsVieewController.orderOptionSelected.value);
      return splashController.isOrderOptionsLoading.value
          ? orderOptionsShimmer()
          : InkWell(
              onTap: () {
                productsVieewController.orderOptionSelected.value = value;
                onTap!();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(7), vertical: screenWidth(80)),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainAppColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(screenWidth(20)),
                  child: Row(
                    children: [
                      CustomRadio(
                        fillColor: AppColors.mainWhiteColor,

                        value: value,
                        selected: productsVieewController.orderOptionSelected
                            .value, // Adjust as per your requirements
                        onTaped: (int value1) {
                          productsVieewController.orderOptionSelected.value =
                              value;
                        },
                      ),
                      screenWidth(40).px,
                      CustomText(
                        text: text,
                        darkTextColor: AppColors.mainBlackColor,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.mainTextColor,
                        textType: TextStyleType.BODYSMALL,
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  showModalBottomSheet(
    elevation: 0,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomPopupWithBlurWidget(
          customBlurChildType: CustomBlurChildType.BOTTOMSHEET,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainWhiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            padding: EdgeInsets.all(screenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: screenWidth(8),
                  height: screenWidth(100),
                  color: AppColors.mainAppColor,
                ),
                screenWidth(30).ph,
                CustomText(
                  text: tr('order_options_lb'),
                  fontWeight: FontWeight.w600,
                  darkTextColor: AppColors.mainBlackColor,
                  textColor: AppColors.mainBlackColor,
                  textType: TextStyleType.SUBTITLE,
                ),
                CustomText(
                  text: tr('how_can_help_lb'),
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.mainBlackColor,
                  darkTextColor: AppColors.mainBlackColor,
                  textType: TextStyleType.SMALL,
                ),
                screenWidth(30).ph,
                ...splashController.orderDeliveryOptions.map((element) {
                  var orderDeliveryOption = element;
                  return buildOption(
                      orderDeliveryOption.name ?? '', orderDeliveryOption.id!,
                      () async {
                    context.pop();
                    if (!orderDeliveryOption.isPickup!) {
                      await LocationService().isPermissionGranted()
                          ? storage.userCurrentLocation == null
                              ? locationService
                                  .getUserCurrentLocation()
                                  .then((value) => Get.to(() => MapPage(
                                        closePanelHeight: 0,
                                      )))
                              : Get.to(() => MapPage(
                                    closePanelHeight: 0,
                                  ))
                          : null;
                    } else {
                      Get.to(
                        const ShopsListView(),
                      );
                    }
                  });
                }),
                screenWidth(30).ph,
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: CustomText(
                    text: tr('skip_now_lb'),
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.mainAppColor,
                    darkTextColor: AppColors.mainAppColor,
                    decoration: TextDecoration.underline,
                    textType: TextStyleType.BODYSMALL,
                  ),
                ),
              ],
            ),
          ));
    },
  );
}

CustomShimmer orderOptionsShimmer() {
  return CustomShimmer(
      isLoading: true,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(7), vertical: screenWidth(80)),
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.mainAppColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(screenWidth(20)),
              child: Container(
                color: AppColors.mainWhiteColor,
              ))));
}