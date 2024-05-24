// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/utility/url_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/profile_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/addresses_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/favorites_view/favorites_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/settings_view/custom_lust_tile.dart';
import 'package:khafif_food_ordering_application/src/ui/views/settings_view/settings_view.dart';

import '../../views/help_center_view/help_center_view.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ProfileController profileController;
  String whatsappNumber = '+966557116527';
  @override
  void initState() {
    super.initState();

    if (userinfo?.value != null) {
      profileController = Get.put(ProfileController());
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget closeIcon = Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
          onPressed: () {
            widget.scaffoldKey.currentState!.closeDrawer();
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
            radius: context.screenWidth(10),
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
      return Container(
        padding: EdgeInsetsDirectional.only(
            top: context.screenWidth(10), start: context.screenWidth(20)),
        color: AppColors.mainAppColor,
        child: InkWell(
          onTap: () {
            Get.to(const ProfileView());
          },
          child: Column(
            children: [
              closeIcon,
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                userImage,
                Padding(
                  padding: EdgeInsets.all(context.screenWidth(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userNameEmail,
                  ),
                )
              ]),
              Padding(
                padding: EdgeInsets.all(context.screenWidth(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(AppAssets.icStarPoints),
                    context.screenWidth(80).px,
                    profileController.isUserPointsLoading.value
                        ? pointsShimmer()
                        : CustomText(
                            darkTextColor: AppColors.mainBlackColor,
                            textType: TextStyleType.SMALL,
                            fontWeight: FontWeight.w500,
                            // textColor: AppColors.mainWhiteColor,
                            text: profileController.intUserPoints.value),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });

    return Theme(
      // ignore: deprecated_member_use
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Drawer(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        shape: ShapeBorder.lerp(InputBorder.none, InputBorder.none, 10.0),
        child: SizedBox(
          // color: AppColors.mainWhiteColor,
          width: context.screenWidth(1.32),
          child: Stack(children: [
            SingleChildScrollView(
              // shrinkWrap: true,
              child: Column(
                children: [
                  Visibility(
                    visible: userinfo?.value != null,
                    child: profileSection,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth(20),
                        vertical: context
                            .screenWidth(userinfo?.value == null ? 10 : 30)),
                    child: SingleChildScrollView(
                      // shrinkWrap: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: userinfo?.value != null,
                            child: Column(
                              children: [
                                CustomIconText(
                                  onTap: () {
                                    Get.to(const ProfileView());
                                  },
                                  imagename: AppAssets.icProfileInfo,
                                  textType: TextStyleType.BODY,
                                  text: tr('my_profile_lb'),
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                          CustomIconText(
                            onTap: () {
                              Get.to(SettingsView());
                            },
                            imagename: AppAssets.icSettings,
                            textType: TextStyleType.BODY,
                            text: tr('settings_lb'),
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              appTheme.toggleTheme();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomIconText(
                                  text: tr('dark_mode_lb'),
                                  textType: TextStyleType.BODY,
                                  image: const Icon(Icons.dark_mode_outlined),
                                ),
                                Switch(
                                    activeColor: Colors.white,
                                    activeTrackColor:
                                        AppColors.swithTileActiveColor,
                                    value: appTheme.isDarkMode.value,
                                    onChanged: (value) {
                                      setState(() {
                                        appTheme.toggleTheme();
                                        // themeController.toggleTheme();
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Divider(
                            height: context.screenWidth(20),
                            color: AppColors.greyColor,
                          ),
                          CustomIconText(
                            onTap: () {
                              Get.to(MyOrderView());
                            },
                            imagename: AppAssets.icBox,
                            textType: TextStyleType.BODY,
                            text: tr('orders_lb'),
                          ),
                          const Divider(),
                          CustomIconText(
                            onTap: () {
                              storage.isLoggedIn
                                  ? Get.to(AddressesView())
                                  : showBrowsingDialogAlert(context);
                            },
                            textType: TextStyleType.BODY,
                            imagename: AppAssets.icAddress,
                            text: tr('addresses_lb'),
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
                            onTap: () {
                              changeLanguageDialog();
                            },
                            image: const Icon(Icons.language),
                            textType: TextStyleType.BODY,
                            text: tr('Languages_lb'),
                          ),

                          // 1.px

                          const Divider(),
                          CustomIconText(
                            // imagecolor: AppColors.mainTextColor,
                            onTap: () {
                              Get.to(FavoritesView());
                            },
                            imageHeight: context.screenWidth(18),
                            imagename: AppAssets.icNotFavorite,
                            text: tr('favorites_lb'),
                            textType: TextStyleType.BODY,
                          ),
                          const Divider(),
                          CustomIconText(
                            onTap: () {
                              Get.to(() => const HelpCenterView());
                            },
                            imagename: AppAssets.icHelp,
                            textType: TextStyleType.BODY,
                            text: tr('help_center_lb'),
                          ),
                          const Divider(),
                          if (!storage.isLoggedIn)
                            CustomIconText(
                              onTap: () {
                                Get.offAll(LoginView());
                              },
                              text: tr('login_lb'),
                              imagename: AppAssets.icSignOut,
                              imageHeight: context.screenWidth(18),
                              imageWidth: context.screenWidth(18),
                            ),
                          if (storage.isLoggedIn)
                            CustomIconText(
                              onTap: () {
                                buildAwsomeDialog(
                                  context: context,
                                  content: tr('logout_warning_dialog'),
                                  firstBtnColor: Colors.red,
                                  secondBtnColor: Colors.green,
                                  firstBtnText: tr('logout_lb'),
                                  secondBtnText: tr('cancel_lb'),
                                  firstBtn: () {
                                    UserRepository().logout();
                                  },
                                );
                              },
                              text: tr('logout_lb'),
                              imagename: AppAssets.icSignOut,
                              imageHeight: context.screenWidth(18),
                              imageWidth: context.screenWidth(18),
                            ),
                          context.screenWidth(15).ph
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: context.screenWidth(50)),
                  color: Get.theme.scaffoldBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          UrlLauncherUtil().startLaunchUrl(
                              url: Uri.parse(
                                  'https://www.facebook.com/khafifCo/'),
                              type: UrlType.WEB);
                        },
                        child: SvgPicture.asset(
                          AppAssets.icFacebookLogo,
                          color: Get.isDarkMode
                              ? AppColors.mainWhiteColor.withOpacity(0.8)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          UrlLauncherUtil().openWhatsApp(whatsappNumber);
                        },
                        child: SvgPicture.asset(
                          AppAssets.icWhatsappLogo,
                          color: Get.isDarkMode
                              ? AppColors.mainWhiteColor.withOpacity(0.8)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          UrlLauncherUtil().startLaunchUrl(
                              url: Uri.parse(
                                  'https://www.instagram.com/khafifco/'),
                              type: UrlType.WEB);
                        },
                        child: SvgPicture.asset(
                          AppAssets.icInstagramLogo,
                          color: Get.isDarkMode
                              ? AppColors.mainWhiteColor.withOpacity(0.8)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          UrlLauncherUtil().startLaunchUrl(
                              url: Uri.parse(
                                  'https://twitter.com/khafifco?lang=ar'),
                              type: UrlType.WEB);
                        },
                        child: SvgPicture.asset(
                          AppAssets.icTwitterLogo,
                          color: Get.isDarkMode
                              ? AppColors.mainWhiteColor.withOpacity(0.8)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          UrlLauncherUtil().startLaunchUrl(
                              url: Uri.parse(
                                  'https://www.tiktok.com/@khafifco?_t=8m0aArA7nrb&_r=1'),
                              type: UrlType.WEB);
                        },
                        child: SvgPicture.asset(
                          AppAssets.icTiktokLogo,
                          color: Get.isDarkMode
                              ? AppColors.mainWhiteColor.withOpacity(0.8)
                              : null,
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
