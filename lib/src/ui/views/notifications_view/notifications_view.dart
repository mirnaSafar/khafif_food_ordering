import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

import 'notifications_controller.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(appbarTitle: tr('notification_lb')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(30), vertical: screenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  print(controller.notificationsModel);
                  return notificationService.notifcationsList.isEmpty
                      ? Center(
                          child: Text(tr('no_notification_lb')),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: 'Today',
                              textType: TextStyleType.SUBTITLE,
                              fontWeight: FontWeight.w800,
                            ),
                            screenWidth(30).ph,
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  notificationService.notifcationsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  // borderRadius: BorderRadius.circular(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.btnMinusColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  // color: AppColors.greenSuccessColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.icNotification,
                                            width: screenWidth(20),
                                            height: screenWidth(20),
                                          ),
                                          screenWidth(30).px,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: notificationService
                                                        .notifcationsList[index]
                                                        .notification!
                                                        .title ??
                                                    '',
                                                fontWeight: FontWeight.w500,
                                                textType:
                                                    TextStyleType.BODYSMALL,
                                              ),
                                              // screenWidth(60).px,
                                              // CustomText(
                                              //   text: notificationService
                                              //           .notifcationsList[index]
                                              //           .notification!
                                              //           .body ??
                                              //       '',
                                              //   textType: TextStyleType.BODY,
                                              // ),
                                              screenWidth(100).ph,
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppAssets.icClock,
                                                    width: screenWidth(25),
                                                    height: screenWidth(25),
                                                  ),
                                                  screenWidth(100).px,
                                                  CustomText(
                                                    text: '30 min ago',
                                                    textColor:
                                                        AppColors.greyTextColor,
                                                    fontWeight: FontWeight.w400,
                                                    textType:
                                                        TextStyleType.SMALL,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // SvgPicture.asset(AppAssets.icShoppingBag),

                                      screenWidth(40).px,
                                      CircleAvatar(
                                        backgroundColor:
                                            AppColors.greenSuccessColor,
                                        maxRadius: 4,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return screenWidth(40).ph;
                              },
                            ),
                          ],
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
