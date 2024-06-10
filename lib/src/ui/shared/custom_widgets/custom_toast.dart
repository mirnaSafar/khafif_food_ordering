// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class CustomToast extends GetxController with WidgetsBindingObserver {
  CustomToast() {
    WidgetsBinding.instance.addObserver(this);
    print('Observer added');
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose(); // Ensures proper cleanup
  }

  void _closeBotToasts() {
    if (WidgetsBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      // BotToast.cleanAll();
      for (var context in _dialogContexts) {
        if (context.mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      }
      _dialogContexts.clear();
      print('BotToast cleaned');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state); // Ensures base class functionality
    print('App lifecycle state changed: $state');
    switch (state) {
      case AppLifecycleState.resumed:
        // Handle the app resuming
        break;
      case AppLifecycleState.inactive:
        // Handle the app becoming inactive
        break;
      case AppLifecycleState.paused:
        _closeBotToasts();

        break;
      case AppLifecycleState.detached:
        // Handle the app being detached
        break;
      case AppLifecycleState.hidden:
      // _closeBotToasts();
      // Clear all toasts

      default:
        break;
    }
  }

  static showMessage(
      {required String message, MessageType? messageType = MessageType.INFO}) {
    String imageName = 'warning';
    Color ShadowColor = AppColors.mainAppColor;

    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected';
        ShadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCESS:
        imageName = 'success1';
        ShadowColor = AppColors.greenSuccessColor;
        break;
      case MessageType.INFO:
        imageName = 'info';
        ShadowColor = Colors.blue;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        ShadowColor = AppColors.mainAppColor;
        break;

      case null:
        break;
    }
    BotToast.showCustomText(
      backgroundColor: AppColors.mainBlackColor.withOpacity(0.2),
      duration: Duration(seconds: 3),
      toastBuilder: (value) {
        return GestureDetector(
          onTap: () {
            BotToast.cleanAll();
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  BotToast.cleanAll();
                },
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: Get.context!.screenWidth(9)),
                    child: Container(
                      width: Get.context!.screenWidth(1.3),
                      decoration: BoxDecoration(
                          color: AppColors.mainWhiteColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ShadowColor.withOpacity(0.5),
                              blurRadius: 7,
                              spreadRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        children: [
                          Get.context!.screenWidth(20).px,
                          Lottie.asset(
                            'assets/lotties/$imageName.json',
                            width: Get.context!.screenWidth(10),
                            height: Get.context!.screenWidth(10),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // SvgPicture.asset(
                                //   'assets/images/$imageName.svg',
                                //   width: context .screenWidth(10),
                                //   height: context .screenWidth(10),
                                // ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Get.context!.screenWidth(25),
                                    horizontal: Get.context!.screenWidth(30),
                                  ),
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                    text: message,
                                    textType: TextStyleType.BODY,
                                    darkTextColor: AppColors.mainBlackColor,
                                    textColor: AppColors.mainBlackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static final List<BuildContext> _dialogContexts = [];
  static AwesomeDialog(
      {Color? firstBtnColor,
      Color? secondBtnColor,
      bool? showMessageWithoutActions = false,
      required String message,
      String? firstBtnText,
      String? secondBtnText,
      void Function()? firstBtnFunction,
      void Function()? secBtnFunction,
      MessageType? messageType = MessageType.INFO}) {
    String imageName = 'warning';
    Color ShadowColor = AppColors.mainAppColor;

    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected';
        ShadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCESS:
        imageName = 'success1';
        ShadowColor = AppColors.greenSuccessColor;
        break;
      case MessageType.INFO:
        imageName = 'info';
        ShadowColor = Colors.blue;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        ShadowColor = AppColors.mainAppColor;
        break;

      case null:
        break;
    }
    return showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) {
          _dialogContexts.add(context);
          if (showMessageWithoutActions!) {
            Future.delayed(Duration(seconds: 5), () {
              if (context.mounted && _dialogContexts.contains(context)) {
                Navigator.of(context).pop(true);
                _dialogContexts.remove(context);
              }
            });
          }
          return GestureDetector(
            onTap: () {
              _dialogContexts.remove(context);
              Get.context!.pop();
            },
            child: Dialog(
              insetPadding: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              insetAnimationDuration:
                  Duration(seconds: showMessageWithoutActions ? 3 : 0),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: context.screenWidth(1.3),
                  decoration: BoxDecoration(
                      color: AppColors.mainWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: showMessageWithoutActions
                          ? [
                              BoxShadow(
                                color: ShadowColor.withOpacity(0.5),
                                blurRadius: 7,
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]
                          : null),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SvgPicture.asset(
                          //   'assets/images/$imageName.svg',
                          //   width: context .screenWidth(10),
                          //   height: context .screenWidth(10),
                          // ),
                          context.screenWidth(20).ph,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: context.screenWidth(
                                  showMessageWithoutActions ? 15 : 25),
                              horizontal: context.screenWidth(30),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                textAlign: TextAlign.center,
                                text: message,
                                fontWeight: FontWeight.w500,
                                textType: TextStyleType.SUBTITLE,
                                darkTextColor: AppColors.mainBlackColor,
                                textColor: AppColors.mainBlackColor,
                              ),
                            ),
                          ),
                          if (!showMessageWithoutActions &&
                              firstBtnText != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: context.screenWidth(3),
                                  child: CustomButton(
                                    borderRadius: BorderRadius.circular(
                                        context.screenWidth(10)),
                                    textColor: AppColors.mainWhiteColor,
                                    textStyleType: TextStyleType.BODYSMALL,
                                    color: firstBtnColor ?? Colors.green,
                                    height: context.screenWidth(30),
                                    text: firstBtnText,
                                    onPressed: () {
                                      // BotToast.cleanAll();
                                      Get.context!.pop();
                                      firstBtnFunction?.call();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: context.screenWidth(3),
                                  child: CustomButton(
                                    borderRadius: BorderRadius.circular(
                                        context.screenWidth(10)),
                                    textStyleType: TextStyleType.BODYSMALL,
                                    textColor: AppColors.mainWhiteColor,
                                    color: secondBtnColor ??
                                        AppColors.mainRedColor,
                                    height: context.screenWidth(30),
                                    text: secondBtnText,
                                    onPressed: () {
                                      Get.context!.pop();
                                      secBtnFunction?.call();

                                      // BotToast.cleanAll();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            context.screenWidth(30).ph,
                          ]
                        ],
                      ),
                      PositionedDirectional(
                        top: -context.screenWidth(5.5),
                        start: context.screenWidth(4.3),
                        child: Lottie.asset(
                          'assets/lotties/$imageName.json',
                          width: context.screenWidth(3.5),
                          height: context.screenWidth(3.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
