import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';

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
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: timeController.selectedTime.value,
    ).then((pickedTime) {
      if (pickedTime != null) {
        timeController.updateTime(pickedTime);
        shopsController.getOpenBranches(
            dateTime: timeController.formatDateTimeIn24(pickedTime),
            branchId: 3);
      }
    });
  }
}
