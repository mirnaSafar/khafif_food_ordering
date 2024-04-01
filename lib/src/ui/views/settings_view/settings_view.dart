import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/settings_view/custom_lust_tile.dart';
import 'package:khafif_food_ordering_application/src/ui/views/settings_view/settings_view_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    SetteingsController controller = Get.put(SetteingsController());
    // var theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppbar(appbarTitle: tr('settings_lb')),
      body: SingleChildScrollView(
        child: Obx(() {
          print(controller.receiveNotification.value);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTile(
                      text: tr('dark_mode_lb'),
                      switcValue: appTheme.isDarkMode.value,
                      onChanged: (value) {
                        setState(() {
                          appTheme.toggleTheme();
                          // themeController.toggleTheme();
                        });
                      }),
                  Divider(
                    height: screenWidth(20),
                    color: AppColors.greyColor,
                  ),
                  CustomListTile(
                      text: tr('notifications_lb'),
                      switcValue: controller.receiveNotification.value,
                      onChanged: (value) async {
                        controller.toogleNotificationStatus();
                      }), // Row(

                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),
                  //
                  InkWell(
                    onTap: () {
                      changeLanguageDialog();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              textColor:
                                  Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                              text: tr('Languages_lb'),
                              textType: TextStyleType.BODY),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: screenWidth(30)),
                            child: InkWell(
                                onTap: () {
                                  changeLanguageDialog();
                                },
                                child: const Icon(Icons.language)),
                          ),
                          // 1.px
                        ],
                      ),
                    ),
                  ),
                  //
                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                    child: InkWell(
                      child: CustomText(
                          textColor: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                          text: tr('feedback_lb'),
                          textType: TextStyleType.BODY),
                    ),
                  ),

                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                    child: InkWell(
                      child: CustomText(
                          fontWeight: FontWeight.w500,
                          textColor: Theme.of(context).colorScheme.secondary,
                          text: tr('privacy_policy_lb'),
                          textType: TextStyleType.BODY),
                    ),
                  ),

                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                    child: InkWell(
                      child: CustomText(
                          fontWeight: FontWeight.w500,
                          textColor: Theme.of(context).colorScheme.secondary,
                          text: tr('delete_account_lb'),
                          textType: TextStyleType.BODY),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}
