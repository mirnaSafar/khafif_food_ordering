import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';

class CustomUserCard extends StatefulWidget {
  const CustomUserCard({super.key});

  @override
  State<CustomUserCard> createState() => _CustomUserCardState();
}

class _CustomUserCardState extends State<CustomUserCard> {
  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return //!-- user card
        Obx(() {
      return InkWell(
        onTap: () {
          controller.flipCard();
        },
        child: CustomContainer(
            containerStyle: ContainerStyle.BIGSQUARE,
            width: screenWidth(1),
            height: screenHeight(4.5),
            backgroundColor: AppColors.mainAppColor,
            child: Stack(
              children: [
                PositionedDirectional(
                    end: 0, child: controller.cardBackground.value),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: screenWidth(30), top: screenWidth(50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: '5%\n',
                                style: TextStyle(
                                    height: 1.1,
                                    color: AppColors.mainBlackColor,
                                    fontSize: controller
                                        .discountPercentFontSize.value,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: 'Discount',
                                style: TextStyle(
                                    color: AppColors.mainBlackColor,
                                    height: 0.4,
                                    fontSize: controller.discountFontSize.value,
                                    fontWeight: FontWeight.w600)),
                            //  CustomTe
                          ])),
                      if (controller.showQrCode.value) ...[
                        screenWidth(60).ph,
                        Image.asset(
                          'assets/images/qr_code.png',
                        )
                      ],
                      !controller.showQrCode.value
                          ? screenWidth(15).ph
                          : screenWidth(60).ph,
                      CustomText(
                          textType: TextStyleType.CUSTOM,
                          fontSize: screenWidth(40),
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.mainWhiteColor,
                          text: tr('from')),
                      CustomText(
                          textType: TextStyleType.CUSTOM,
                          fontSize: screenWidth(51),
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.mainWhiteColor,
                          text: tr('limit_lb')),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
