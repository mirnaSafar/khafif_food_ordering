import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';

class CustomDatePicker {
  final DateTimeController dateController = Get.put(DateTimeController());

  showDateDialog(BuildContext context) {
    dateController.selectDate(context);
  }
}
