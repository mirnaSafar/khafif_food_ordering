import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

import '../../../core/app/app_config/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../../core/app/app_config/fonts.dart';
import 'intro_controller.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget>
    with TickerProviderStateMixin {
  IntroController controller = Get.put(IntroController());
  // late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller.animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 400), // Example: 400 milliseconds transition duration
    );
    _animation = CurvedAnimation(
      parent: controller.animationController,
      curve: Curves
          .easeIn, // Example: Using an ease-in curve for smooth transition
    );
    controller.startAutoTransition(); // Start automatic transition
  }

  @override
  void dispose() {
    controller.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/popcorn.png'),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  height: screenHeight(1.8),
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                      // color: AppColors.mainBlackColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        screenWidth(30).ph,
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) => Opacity(
                            opacity: _animation.value,
                            child: Column(
                              children: [
                                Text(
                                  controller
                                      .titleList[controller.currentIndex.value],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1.3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.headerBig,
                                    // color: AppColors.mainWhiteColor,
                                  ),
                                ),
                                screenWidth(30).ph,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: screenWidth(9)),
                                  child: SizedBox(
                                    height: screenWidth(5),
                                    child: Text(
                                      controller.descriptionList[
                                          controller.currentIndex.value],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.mainGreyColor,
                                        fontSize: AppFonts.bodySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // screenHeight(40).ph,
                        DotsIndicator(
                          dotsCount: 3,
                          position: controller.currentIndex.value,
                          decorator: DotsDecorator(
                              color: AppColors.greyColor,
                              activeColor: AppColors.mainAppColor),
                        ),
                        screenHeight(10).ph,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: screenWidth(20)),
                          child: CustomButton(
                            text: controller.getDotsStatusText,
                            onPressed: () {
                              storage.setFirstLaunch(false);
                              Get.off(const ProductsView());
                            },
                          ),
                        ),
                        screenHeight(30).ph,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
