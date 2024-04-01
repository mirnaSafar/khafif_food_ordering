import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class NoConnetionWidget extends StatelessWidget {
  const NoConnetionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool refreshing = false.obs;
    return Obx(() {
      return refreshing.value
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.mainAppColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                screenWidth(3).ph,
                // Image.asset(
                //   'assets/images/OIP.jpeg',
                //   width: screenHeight(3),
                // ),
                Icon(Icons.wifi_off_rounded,
                    color: AppColors.greyColor, size: screenWidth(3)),
                screenWidth(30).ph,
                CustomText(
                  text: tr('no_internet_lb'),
                  textType: TextStyleType.HEADER,
                ),
                CustomText(
                  text: tr('check_internet_lb'),
                  textType: TextStyleType.BODY,
                ),
                screenWidth(10).ph,
                Obx(() {
                  print(refreshing.value);
                  return SizedBox(
                    width: screenWidth(2.5),
                    height: screenWidth(9),
                    child: CustomButton(
                      textColor: AppColors.mainAppColor,
                      borderColor: AppColors.mainAppColor,
                      color: context.theme.scaffoldBackgroundColor,
                      onPressed: () {
                        refreshing.value = true;
                        Future.delayed(const Duration(milliseconds: 600), () {
                          homeRefreshingMethod();

                          refreshing.value = false;
                        });
                      },
                      child: Row(children: [
                        Icon(
                          Icons.restart_alt_outlined,
                          color: AppColors.mainAppColor,
                        ),
                        screenWidth(40).px,
                        CustomText(
                            darkTextColor: AppColors.mainAppColor,
                            textColor: AppColors.mainAppColor,
                            textType: TextStyleType.BODYSMALL,
                            text: tr('refresh_lb'))
                      ]),
                    ),
                  );
                }),
              ],
            );
    });
  }
}
