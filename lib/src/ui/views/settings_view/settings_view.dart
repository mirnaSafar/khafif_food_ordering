import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/utility/url_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
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
    return Scaffold(
      appBar: CustomAppbar(appbarTitle: tr('settings_lb')),
      body: SingleChildScrollView(
        child: Obx(() {
          print(controller.receiveNotification.value);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      appTheme.toggleTheme();
                    },
                    child: CustomListTile(
                        text: tr('dark_mode_lb'),
                        switcValue: appTheme.isDarkMode.value,
                        onChanged: (value) {
                          setState(() {
                            appTheme.toggleTheme();
                            // themeController.toggleTheme();
                          });
                        }),
                  ),
                  Divider(
                    height: screenWidth(20),
                    color: AppColors.greyColor,
                  ),
                  InkWell(
                    onTap: () {
                      controller.toogleNotificationStatus();
                    },
                    child: CustomListTile(
                        text: tr('notifications_lb'),
                        switcValue: controller.receiveNotification.value,
                        onChanged: (value) async {
                          controller.toogleNotificationStatus();
                        }),
                  ), // Row(

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

                  SizedBox(
                    width: screenWidth(1),
                    height: screenWidth(8),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: InkWell(
                        child: CustomText(
                            textColor: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                            text: tr('feedback_lb'),
                            textType: TextStyleType.BODY),
                      ),
                    ),
                  ),

                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),

                  InkWell(
                    onTap: () {
                      UrlLauncherUtil().startLaunchUrl(
                          url: Uri.parse('https://erp.khafif.com.sa/privacy'),
                          type: UrlType.WEB);
                    },
                    child: SizedBox(
                      width: screenWidth(1),
                      height: screenWidth(8),
                      // padding: EdgeInsets.symmetric(vertical: screenWidth(30)),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).colorScheme.secondary,
                            text: tr('privacy_policy_lb'),
                            textType: TextStyleType.BODY),
                      ),
                    ),
                  ),

                  Divider(
                    color: AppColors.greyColor,
                    height: screenWidth(20),
                  ),

                  InkWell(
                    child: SizedBox(
                      width: screenWidth(1),
                      height: screenWidth(8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                            fontWeight: FontWeight.w500,
                            textColor: Theme.of(context).colorScheme.secondary,
                            text: tr('delete_account_lb'),
                            textType: TextStyleType.BODY),
                      ),
                    ),
                  ),
                  screenWidth(10).ph,
                  CustomIconText(
                    mainAxisAlignment: MainAxisAlignment.center,
                    onTap: () {
                      buildAwsomeDialog(
                        context: context,
                        content: tr('logout_warning_dialog'),
                        secondBtnText: tr('logout_lb'),
                        firstBtnText: tr('cancel_lb'),
                        secondBtn: () {
                          UserRepository().logout();
                        },
                      );
                    },
                    imagecolor: AppColors.mainRedColor,
                    textcolor: AppColors.mainRedColor,
                    text: tr('logout_lb'),
                    imagename: AppAssets.icSignOut,
                    imageHeight: screenWidth(18),
                    imageWidth: screenWidth(18),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}