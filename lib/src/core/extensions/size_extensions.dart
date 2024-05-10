import 'package:flutter/widgets.dart';

extension ScreenSize on BuildContext {
  double screenWidth(double percent) {
    final width = MediaQuery.of(this).size.width;
    return width / percent;
    // return Get.size.width / percent;/
  }

  double screenHeight(double percent) {
    // return Get.size.height / percent;
    final height = MediaQuery.of(this).size.height;
    return height / percent;
  }
}
