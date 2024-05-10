// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_popup_with_blur.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

import '../../../shared/custom_widgets/custom_button.dart';

showDeliveryCheckerDialog(
    {void Function()? onPressed, String? btnText, String? subtitle}) {
  showDialog(
    barrierColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => CustomPopupWithBlurWidget(
      customBlurChildType: CustomBlurChildType.DIALOUG,
      child: Center(
        child: CustomContainer(
            borderRadius: BorderRadius.circular(14),
            height: Get.context!.screenHeight(2.7),
            width: Get.context!.screenWidth(1.1),
            backgroundColor: AppColors.mainWhiteColor,
            padding: EdgeInsets.all(Get.context!.screenWidth(30)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Image.asset(AppAssets.icDeliveryChecker),
                        Get.context!.screenWidth(20).ph,
                        DefaultTextStyle(
                          style: TextStyle(),
                          child: CustomText(
                            text: tr('delivery_checker_lb'),
                            darkTextColor: AppColors.mainBlackColor,
                            textType: TextStyleType.SUBTITLE,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Get.context!.screenWidth(20).ph,
                        Center(
                          child: DefaultTextStyle(
                            style: TextStyle(),
                            child: SizedBox(
                              width: Get.context!.screenWidth(1.5),
                              child: CustomText(
                                  textColor: AppColors.mainBlackColor,
                                  fontWeight: FontWeight.w400,
                                  darkTextColor: AppColors.mainBlackColor,
                                  text: subtitle ?? tr('ability_to_deliver_lb'),
                                  textType: TextStyleType.BODY),
                            ),
                          ),
                        ),
                        Get.context!.screenWidth(20).ph,
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: onPressed,
                          fontsize: context.screenWidth(34),
                          textStyleType: TextStyleType.CUSTOM,
                          height: Get.context!.screenWidth(8),
                          text: btnText ?? tr('confirm_location_lb'),
                        ),
                      ),
                      Get.context!.screenWidth(70).px,
                      Expanded(
                        child: CustomButton(
                          onPressed: () => Get.context!.pop(),
                          fontsize: context.screenWidth(34),
                          textStyleType: TextStyleType.CUSTOM,
                          height: Get.context!.screenWidth(8),
                          text: tr('select_other_location_lb'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    ),
  );
}

showproductImageDialog({required String image}) {
  showDialog(
    barrierColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => CustomPopupWithBlurWidget(
      customBlurChildType: CustomBlurChildType.DIALOUG,
      child: Center(
          child: CustomContainer(
              borderRadius: BorderRadius.circular(14),
              height: Get.context!.screenHeight(2.7),
              width: Get.context!.screenWidth(1.1),
              backgroundColor: AppColors.mainWhiteColor,
              padding: EdgeInsets.all(Get.context!.screenWidth(30)),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomNetworkImage(imageUrl: image)))),
    ),
  );
}
