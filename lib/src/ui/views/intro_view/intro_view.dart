// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

import '../../../core/app/app_config/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../../core/app/app_config/fonts.dart';
import 'intro_controller.dart';

class IntroWidget extends StatefulWidget {
  IntroWidget({super.key});

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
      duration: Duration(
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
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Obx(() {
          print(controller.currentIndex.value);
          return FutureBuilder(
              future: whenNotZero(
                Stream<double>.periodic(Duration(milliseconds: 50),
                    (x) => MediaQuery.of(context).size.width),
              ),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data! > 0) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/images/popcorn.png'),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Container(
                            height: context.screenHeight(1.8),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                // color: AppColors.mainBlackColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24))),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  context.screenWidth(30).ph,
                                  AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) => Opacity(
                                      opacity:
                                          controller.currentIndex.value == 0
                                              ? 1
                                              : _animation.value,
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.titleList[
                                                controller.currentIndex.value],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              height: 1.3,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppFonts(context).headerBig,
                                              // color: AppColors.mainWhiteColor,
                                            ),
                                          ),
                                          context.screenWidth(30).ph,
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal:
                                                    context.screenWidth(9)),
                                            child: SizedBox(
                                              height: context.screenWidth(5),
                                              child: Text(
                                                controller.descriptionList[
                                                    controller
                                                        .currentIndex.value],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.mainGreyColor,
                                                  fontSize: AppFonts(context)
                                                      .bodySmall,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // context .screenHeight(40).ph,
                                  DotsIndicator(
                                    dotsCount: 3,
                                    position: controller.currentIndex.value,
                                    decorator: DotsDecorator(
                                        color: AppColors.greyColor,
                                        activeColor: AppColors.mainAppColor),
                                  ),
                                  context.screenHeight(10).ph,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: context.screenWidth(20)),
                                    child: CustomButton(
                                      text: controller.getDotsStatusText,
                                      onPressed: () {
                                        storage.setFirstLaunch(false);
                                        Get.off(ProductsView());
                                      },
                                    ),
                                  ),
                                  context.screenHeight(30).ph,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return Container();
              });
        }),
      ),
    );
  }
}
