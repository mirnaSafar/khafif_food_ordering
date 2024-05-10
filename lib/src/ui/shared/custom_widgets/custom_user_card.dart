// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/profile_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/qr_view.dart/qr_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomUserCard extends StatefulWidget {
  CustomUserCard({super.key});

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
                  vertical: context.screenWidth(20),
                  horizontal: context.screenWidth(20),
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
                              text:
                                  (controller.userPointsModel.value.name ?? '')
                                          .split(':')[0] +
                                      tr('wanees_ponts_lb'),
                              textType: TextStyleType.SUBTITLE),
                        ),
                        // context .screenWidth(100).px,
                        Container(
                          width: context.screenWidth(10),
                          height: context.screenWidth(15),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white)),
                          child: Icon(
                            Icons.question_mark_rounded,
                            size: context.screenWidth(20),
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
                      fontSize: context.screenWidth(38),
                      textType: TextStyleType.CUSTOM,
                    ),
                    context.screenWidth(10).ph,
                    CustomText(
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.mainWhiteColor,
                      darkTextColor: AppColors.mainWhiteColor,
                      text: tr('available'),
                      fontSize: context.screenWidth(38),
                      textType: TextStyleType.CUSTOM,
                    ),
                    SizedBox(
                      height: context.screenWidth(8.3),
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
                                fontSize: context.screenWidth(10),
                                textType: TextStyleType.CUSTOM),
                      ),
                    ),
                    CustomText(
                        textType: TextStyleType.CUSTOM,
                        fontSize: context.screenWidth(33),
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.mainWhiteColor,
                        text: tr('from')),
                    CustomText(
                        textType: TextStyleType.CUSTOM,
                        fontSize: context.screenWidth(51),
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.mainWhiteColor,
                        text: tr('limit_lb')),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  // vertical: context .screenWidth(60),
                  horizontal: context.screenWidth(40),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Get.to(QRScreen()),
                      child: SizedBox(
                        width: context.screenWidth(2.9),
                        // height: context .screenWidth(3.0),
                        child: QrImageView(
                          data: Get.find<ProfileController>().userCode.value,
                        ),
                      ).paddingOnly(top: 0, bottom: context.screenWidth(30)),
                    ),
                    Image.asset(
                      'assets/images/khafif logo without Back.png',
                      height: context.screenWidth(9.5),
                      width: context.screenWidth(5.2),
                    ),
                    context.screenWidth(30).ph,
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
