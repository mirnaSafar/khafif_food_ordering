import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/date_time_picker/custom_time_picker_widget.dart';

class DateTimeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: AppColors.mainAppColor, // header background color
            // onPrimary: Colors.black, // header text color
            // onSurface: Colors.green, // body text color
          )),
          child: DatePickerTheme(
              data: DatePickerThemeData(
                headerBackgroundColor: AppColors.mainAppColor,
              ),
              child: child!),
        );
      },
      helpText: tr('select_order_date_lb'),
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      selectedDate(pickedDate);
      // ignore: use_build_context_synchronously
      CustomTimePicker().showTimeDialog(context);
    }
  }

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  void updateTime(TimeOfDay newTime) {
    selectedTime(newTime);
  }

  String formatDateTimeIn24(TimeOfDay pickedTime) {
    // Parse the input string to a DateTime object
    String selectedDateOnly = selectedDate.toString().split(' ')[0];
    String selectedTime = pickedTime.format(Get.context!).toString();
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm a")
        .parse('$selectedDateOnly $selectedTime');

    // Format the DateTime object to a new 24-hour format string
    String formattedDateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
    return formattedDateTime;
  }

  DateTime parseFormattedStringDateTimeInToDateTimeObject(
      TimeOfDay pickedTime) {
    String selectedDateOnly = selectedDate.toString().split(' ')[0];
    String selectedTime = pickedTime.format(Get.context!).toString();
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm a")
        .parse('$selectedDateOnly $selectedTime');

    return dateTime;
  }

  String parse24TimeToDayPeriod({required String stringDateTime}) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(stringDateTime);
    String formattedDateTime = DateFormat("yyyy-MM-dd h:mm a").format(dateTime);
    return formattedDateTime;
  }

  String parse24TimeTo12({required String timeIn24}) {
    DateTime time = DateTime.parse('2000-01-01 $timeIn24:00');
    return DateFormat('h:mm a').format(time);
  }
}
