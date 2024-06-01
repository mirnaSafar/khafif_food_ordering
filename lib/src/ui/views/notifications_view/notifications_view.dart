// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

import 'notifications_controller.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appbarTitle: tr('notification_lb')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth(30),
              vertical: context.screenWidth(20)),
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
                          CustomText(
                            text: 'Today',
                            textType: TextStyleType.SUBTITLE,
                            fontWeight: FontWeight.w800,
                          ),
                          context.screenWidth(30).ph,
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
                                          width: context.screenWidth(20),
                                          height: context.screenWidth(20),
                                        ),
                                        context.screenWidth(30).px,
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
                                              textType: TextStyleType.BODYSMALL,
                                            ),
                                            // context .screenWidth(60).px,
                                            // CustomText(
                                            //   text: notificationService
                                            //           .notifcationsList[index]
                                            //           .notification!
                                            //           .body ??
                                            //       '',
                                            //   textType: TextStyleType.BODY,
                                            // ),
                                            context.screenWidth(100).ph,
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.icClock,
                                                  width:
                                                      context.screenWidth(25),
                                                  height:
                                                      context.screenWidth(25),
                                                ),
                                                context.screenWidth(100).px,
                                                CustomText(
                                                  text: '30 min ago',
                                                  textColor:
                                                      AppColors.greyTextColor,
                                                  fontWeight: FontWeight.w400,
                                                  textType: TextStyleType.SMALL,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // SvgPicture.asset(AppAssets.icShoppingBag),

                                    context.screenWidth(40).px,
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
                              return context.screenWidth(40).ph;
                            },
                          ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
