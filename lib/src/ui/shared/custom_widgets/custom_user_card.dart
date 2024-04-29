import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/profile_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/qr_view.dart/qr_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      return CustomContainer(
          backgroundColor: AppColors.mainAppColor,
          containerStyle: ContainerStyle.BIGSQUARE,
          // height: screenHeight(3.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenWidth(20),
                  horizontal: screenWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(fontFamily: 'Roboto'),
                          child: CustomText(
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainWhiteColor,
                              darkTextColor: AppColors.mainWhiteColor,
                              text: tr('wanees_ponts_lb'),
                              textType: TextStyleType.SUBTITLE),
                        ),
                        screenWidth(60).px,
                        Container(
                          width: screenWidth(10),
                          height: screenWidth(15),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white)),
                          child: Icon(
                            Icons.question_mark_rounded,
                            size: screenWidth(20),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    CustomText(
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.mainWhiteColor,
                      darkTextColor: AppColors.mainWhiteColor,
                      text: tr('walaa_lb'),
                      fontSize: screenWidth(38),
                      textType: TextStyleType.CUSTOM,
                    ),
                    screenWidth(10).ph,
                    CustomText(
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.mainWhiteColor,
                      darkTextColor: AppColors.mainWhiteColor,
                      text: tr('available'),
                      fontSize: screenWidth(38),
                      textType: TextStyleType.CUSTOM,
                    ),
                    SizedBox(
                      height: screenWidth(8.3),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: controller.isUserPointsLoading.value
                            ? pointsShimmer()
                            : CustomText(
                                // textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.mainWhiteColor,
                                darkTextColor: AppColors.mainWhiteColor,
                                text: Get.find<ProfileController>()
                                    .intUserPoints
                                    .value,
                                fontSize: screenWidth(10),
                                textType: TextStyleType.CUSTOM),
                      ),
                    ),
                    CustomText(
                        textType: TextStyleType.CUSTOM,
                        fontSize: screenWidth(33),
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
              Padding(
                padding: EdgeInsets.symmetric(
                  // vertical: screenWidth(60),
                  horizontal: screenWidth(20),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Get.to(const QRScreen()),
                      child: SizedBox(
                        width: screenWidth(2.9),
                        // height: screenWidth(3.0),
                        child: QrImageView(
                          data: Get.find<ProfileController>().userCode.value,
                        ),
                      ).paddingOnly(top: 0, bottom: screenWidth(30)),
                    ),
                    Image.asset(
                      'assets/images/khafif logo without Back.png',
                      height: screenWidth(9.5),
                      width: screenWidth(5.2),
                    ),
                    screenWidth(30).ph,
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
