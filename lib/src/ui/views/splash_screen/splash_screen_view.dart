import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(fit: StackFit.expand, children: [
            // SvgPicture.asset(
            //   AppAssets.icFavorite,
            // ),
            // Center(
            //   child: SvgPicture.asset(
            //     'assets/images/logo.svg',
            //   ),
            // ),
            Lottie.asset('assets/lotties/popcorn_loading.json',
                // width: screenWidth(11),
                // height: screenWidth(11),
                fit: BoxFit.fitWidth)
          ]),
        ),
      ),
    );
  }
}
