import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';

class IntroController extends BaseController {
  late AnimationController animationController;

  void startAutoTransition() {
    const duration = Duration(seconds: 3);
    Timer.periodic(duration, (Timer t) {
      if (currentIndex.value < 2) {
        currentIndex.value++;
      } else {
        currentIndex.value = 0;
      }
      animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<String> titleList = [
    tr('fast_delivery_lb'),
    'Fast Delivery',
    'Live Tracking'
  ];

  List<String> descriptionList = [
    tr("intro_first_description_text"),
    'Fast food delivery to your home, office \n wherever you are',
    'Real time tracking of your food on the app \n once you placed the order,'
  ];

  RxInt currentIndex = 0.obs;

  String get getDotsStatusText => 'lets go';

  void monitorDotsState() {
    currentIndex.value != 2 ? currentIndex += 1 : Get.to(LoginView());
  }
}
