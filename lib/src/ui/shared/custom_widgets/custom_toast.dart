import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:lottie/lottie.dart';

class CustomToast {
  static showMessage(
      {required String message, MessageType? messageType = MessageType.INFO}) {
    String imageName = 'info';
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
      duration: const Duration(seconds: 3),
      toastBuilder: (value) {
        return Stack(
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
                  padding: EdgeInsets.only(bottom: screenWidth(9)),
                  child: Container(
                    width: screenWidth(1.3),
                    decoration: BoxDecoration(
                        color: AppColors.mainWhiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: ShadowColor.withOpacity(0.5),
                            blurRadius: 7,
                            spreadRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Row(
                      children: [
                        screenWidth(20).px,
                        Lottie.asset(
                          'assets/lotties/$imageName.json',
                          width: screenWidth(10),
                          height: screenWidth(10),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // SvgPicture.asset(
                              //   'assets/images/$imageName.svg',
                              //   width: screenWidth(10),
                              //   height: screenWidth(10),
                              // ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenWidth(25),
                                  horizontal: screenWidth(30),
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
            // Positioned(
            //     bottom: 0,
            //     child: ClipRRect(
            //       borderRadius:
            //           const BorderRadius.only(bottomLeft: Radius.circular(20)),
            //       child: SvgPicture.asset(
            //         'assets/images/bubble-svgrepo-com.svg',
            //         width: screenWidth(10),
            //         height: screenWidth(7),
            //         color: ShadowColor.withOpacity(0.4),
            //       ),
            //     )),
            // PositionedDirectional(
            //   top: -screenWidth(11.6),
            //   start: screenWidth(3.2),
            //   child: Lottie.asset(
            //     'assets/lotties/$imageName.json',
            //     width: screenWidth(8),
            //     height: screenWidth(8),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
