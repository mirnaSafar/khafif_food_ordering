// ignore_for_file: prefer_const_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shop_bottomsheet.dart';

class CustomTimePicker {
  DateTimeController timeController = Get.put(DateTimeController());
  ShopsController shopsController = Get.put(ShopsController());
  showTimeDialog(BuildContext context) {
    showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
                // change the border color
                primary: AppColors.mainAppColor,
                inverseSurface: AppColors.mainAppColor,
                onSecondary: AppColors.mainWhiteColor,
                secondary: AppColors.mainAppColor
                // change the text color
                // onSurface: Colors.purple,
                ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: child!,
        );
      },
      helpText: tr('select_order_time_lb'),
      context: context,
      initialTime: timeController.selectedTime.value,
    ).then((pickedTime) {
      if (pickedTime != null) {
        timeController.updateTime(pickedTime);
        if (timeController
            .parseFormattedStringDateTimeInToDateTimeObject(pickedTime)
            .add(const Duration(minutes: 2))
            .isBefore(DateTime.now())) {
          CustomToast.AwesomeDialog(
              showMessageWithoutActions: true,
              message: tr('time_is_invalid'),
              messageType: MessageType.REJECTED);
        } else {
          shopsController.selectedBranchesDisplayOption.value = 2;
          shopsController
              .getOpenBranches(
                  dateTime: timeController.formatDateTimeIn24(pickedTime),
                  branchId: 3)
              .then((value) => shopsController.openShopsList.isEmpty
                  ? null
                  : Get.to(MapPage(
                      showAllbranchesButton: true,
                      sourceLocation: LatLng(
                        shopsController.shopsList[0].latitude!,
                        shopsController.shopsList[0].longitude!,
                      ),
                      bottomsheet: ShopBottomSheet(
                        shop: shopsController.shopsList[0],
                        shops: shopsController.shopsList,
                      ),
                      appBarTitle: tr('shops_lb'),
                    )));
        }
      }
    });
  }
}
