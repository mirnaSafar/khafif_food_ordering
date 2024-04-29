import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custum_rich_text.dart';

enum OrderStatusEnum { READY, UNDERDELIVERY, CANCELED }

class OrderStatus extends StatelessWidget {
  final String orderNo, orderDate, orderPrice;
  final OrderStatusEnum orderStatusEnum;

  const OrderStatus(
      {super.key,
      required this.orderNo,
      required this.orderDate,
      required this.orderPrice,
      required this.orderStatusEnum});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        backgroundColor: Colors.white,
        shadowColor: AppColors.shadowColor,
        blurRadius: 4,
        offset: const Offset(0, 4),
        borderRadius: BorderRadius.circular(5),
        padding: EdgeInsets.symmetric(
            vertical: screenWidth(20), horizontal: screenWidth(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomRichText(
                firstText: tr('order_no_lb'),
                secondText: orderNo,
                firstFontWeight: FontWeight.w400,
                secondFontWeight: FontWeight.w600,
                firstFontSize: AppFonts.body,
                firstColor: AppColors.mainBlackColor,
                secondColor: AppColors.mainBlackColor,
                secondFontSize: AppFonts.body,
              ),
              screenWidth(40).ph,
              CustomText(
                text: orderDate,
                darkTextColor: AppColors.mainBlackColor,
                textType: TextStyleType.SMALL,
                fontWeight: FontWeight.w400,
                textColor: AppColors.placeholderTextColor,
              ),
              screenWidth(40).ph,
              CustomRichText(
                firstText: tr('price_lb'),
                secondText: orderPrice,
                firstFontWeight: FontWeight.w400,
                firstColor: AppColors.mainBlackColor,
                secondColor: AppColors.mainBlackColor,
                secondFontWeight: FontWeight.w500,
                firstFontSize: AppFonts.small,
                secondFontSize: AppFonts.bodySmall,
              ),
            ]),
            orderStatusTextStyle,
          ],
        )).paddingSymmetric(
      vertical: screenWidth(40),
    );
  }

  CustomText get orderStatusTextStyle {
    switch (orderStatusEnum) {
      case OrderStatusEnum.UNDERDELIVERY:
        return CustomText(
          text: tr('under_delivery_lb'),
          textType: TextStyleType.BODY,
          fontWeight: FontWeight.w500,
          textColor: AppColors.mainAppColor,
          darkTextColor: AppColors.mainAppColor,
        );
      case OrderStatusEnum.READY:
        return CustomText(
          text: tr('redy_lb'),
          fontWeight: FontWeight.w500,
          textType: TextStyleType.BODY,
          darkTextColor: AppColors.greenSuccessColor,
          textColor: AppColors.greenSuccessColor,
        );
      case OrderStatusEnum.CANCELED:
        return CustomText(
          text: tr('canceled_lb'),
          fontWeight: FontWeight.w500,
          textType: TextStyleType.BODY,
          textColor: AppColors.canceledRedColor,
          darkTextColor: AppColors.canceledRedColor,
        );
    }
  }
}
