// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(fit: StackFit.expand, children: [
          Transform.scale(
            scale: 0.6,
            child: Image.asset(
              'assets/images/khafif logo without Back.png',
              width: context.screenWidth(40),
              height: context.screenWidth(40),
            ),
          )
        ]),
      ),
    );
  }
}
