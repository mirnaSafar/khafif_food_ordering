import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/addresses_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/favorites_view/favorites_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    Widget closeIcon = Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
          onPressed: () {
            scaffoldKey.currentState!.closeDrawer();
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          )),
    );

    var userImage = Visibility(
      visible: userinfo?.value != null,
      child: InkWell(
        onTap: () {
          Get.to(const ProfileView());
        },
        child: CircleAvatar(
            backgroundColor: AppColors.mainWhiteColor,
            radius: screenWidth(10),
            backgroundImage: NetworkImage(
              userinfo?.value?.image ?? '',
            )),
      ),
    );

    var userNameEmail = [
      Obx(() {
        print(userinfo?.value);
        return Visibility(
          visible: userinfo?.value != null,
          child: CustomText(
              text: userinfo?.value?.name ?? '',
              fontWeight: FontWeight.bold,
              textType: TextStyleType.BODY),
        );
      }),
      Visibility(
        visible: userinfo?.value != null,
        child: CustomText(
            text: userinfo?.value?.email ?? '', textType: TextStyleType.SMALL),
      ),
    ];

    Widget profileSection = Obx(() {
      print(userinfo?.value);
      return InkWell(
        onTap: () {
          Get.to(const ProfileView());
        },
        child: Container(
          height: screenHeight(5),
          padding: EdgeInsetsDirectional.only(start: screenWidth(20)),
          color: AppColors.mainAppColor,
          child: Column(
            children: [
              closeIcon,
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                userImage,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userNameEmail,
                  ),
                )
              ]),
            ],
          ),
        ),
      );
    });

    return Drawer(
      child: SizedBox(
        // color: AppColors.mainWhiteColor,
        width: screenWidth(1.32),
        child: Column(children: [
          Visibility(
            visible: userinfo?.value != null,
            child: profileSection,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(20), vertical: screenWidth(25)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomIconText(
                    onTap: () {},
                    imagename: AppAssets.icAddUser,
                    textType: TextStyleType.BODY,
                    text: tr('invite_friends_lb'),
                  ),
                  const Divider(),
                  CustomIconText(
                    onTap: () {},
                    imagename: AppAssets.icTicket,
                    textType: TextStyleType.BODY,
                    text: tr('offers_lb'),
                  ),
                  const Divider(),
                  CustomIconText(
                    // imagecolor: AppColors.mainTextColor,
                    onTap: () {
                      Get.to(const FavoritesView());
                    },
                    imagename: AppAssets.icNotFavorite,
                    text: tr('favorites_lb'),
                    textType: TextStyleType.BODY,
                  ),
                  const Divider(),
                  CustomIconText(
                    onTap: () {},
                    imagename: AppAssets.icHelp,
                    textType: TextStyleType.BODY,
                    text: tr('help_center_lb'),
                  ),
                  const Divider(),
                  CustomIconText(
                    onTap: () {
                      storage.isLoggedIn
                          ? Get.to(const AddressesView())
                          : showBrowsingDialogAlert(context);
                    },
                    textType: TextStyleType.BODY,
                    imagename: AppAssets.icAddress,
                    text: tr('addresses_lb'),
                  ),
                  const Divider(),
                  CustomIconText(
                    onTap: () {
                      Get.offAll(const LoginView());
                    },
                    text: tr('login_lb'),
                    imagename: AppAssets.icSignOut,
                    imageHeight: screenWidth(18),
                    imageWidth: screenWidth(18),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
