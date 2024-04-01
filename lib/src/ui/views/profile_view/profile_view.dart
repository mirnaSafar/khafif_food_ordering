import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custoum_rate.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/addresses_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/my_information.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/custom_info_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/views/profile_view/profile_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/settings_view/settings_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: CustomAppbar(appbarTitle: tr('personal_details_lb')),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(20), vertical: screenWidth(20)),
                child: Obx(() {
                  print(controller.showQrCode.value);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomContainer(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(40),
                              vertical: screenWidth(50)),
                          backgroundColor: AppColors.mainWhiteColor,
                          containerStyle: ContainerStyle.BIGSQUARE,
                          blurRadius: 4,
                          shadowColor: AppColors.shadowColor,
                          offset: const Offset(0, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomContainer(
                                      containerStyle:
                                          ContainerStyle.SMALLSQUARE,
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      width: screenWidth(5),
                                      height: screenWidth(5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CustomNetworkImage(
                                          scale: 1.2,
                                          imageUrl:
                                              userinfo?.value!.image ?? '',
                                        ),
                                      )),
                                  screenWidth(30).px,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          darkTextColor:
                                              AppColors.mainBlackColor,
                                          textType: TextStyleType.BODY,
                                          fontWeight: FontWeight.w600,
                                          text: userinfo?.value!.name ?? ''),
                                      CustomText(
                                        darkTextColor: AppColors.mainBlackColor,
                                        textType: TextStyleType.SMALL,
                                        fontWeight: FontWeight.w400,
                                        textColor: AppColors.mainGreyColor,
                                        text:
                                            '${userinfo?.value!.phone!.substring(0, 6)}XXXXXXXX',
                                      ),
                                      CustomText(
                                        darkTextColor: AppColors.mainBlackColor,
                                        textType: TextStyleType.SMALL,
                                        fontWeight: FontWeight.w400,
                                        textColor: AppColors.mainGreyColor,
                                        text: storage.userStreetName,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              screenWidth(8).px,
                              CustomContainer(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenWidth(50),
                                    horizontal: screenWidth(48),
                                  ),
                                  containerStyle: ContainerStyle.CIRCLE,
                                  backgroundColor: AppColors.mainAppColor,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.icStarPoints),
                                      screenWidth(80).px,
                                      CustomText(
                                          darkTextColor:
                                              AppColors.mainBlackColor,
                                          textType: TextStyleType.SMALL,
                                          fontWeight: FontWeight.w500,
                                          // textColor: AppColors.mainWhiteColor,
                                          text: "930.000"),
                                    ],
                                  ))
                            ],
                          )),
                      screenWidth(20).ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomInfoWidget(
                            text: tr('settings_lb'),
                            imagename: AppAssets.icSettings,
                            onTap: () {
                              Get.to(const SettingsView());
                            },
                          ),
                          CustomInfoWidget(
                            onTap: () {
                              Get.to(const MyInformationView());
                            },
                            text: tr('info_lb'),
                            imagename: AppAssets.icProfileInfo,
                          ),
                          CustomInfoWidget(
                            onTap: () {
                              Get.to(const AddressesView());
                            },
                            text: tr('addresses_lb'),
                            imagename: AppAssets.icAddress,
                          ),
                          CustomInfoWidget(
                            onTap: () {
                              Get.to(const MyOrderView());
                            },
                            text: tr('orders_lb'),
                            imagename: AppAssets.icBox,
                          ),
                        ],
                      ),
                      screenWidth(15).ph,

                      //!-- user card
                      InkWell(
                        onTap: () {
                          controller.flipCard();
                        },
                        child: CustomContainer(
                            containerStyle: ContainerStyle.BIGSQUARE,
                            width: screenWidth(1),
                            height: screenHeight(4.5),
                            backgroundColor: AppColors.mainAppColor,
                            child: Stack(
                              children: [
                                PositionedDirectional(
                                    end: 0,
                                    child: controller.cardBackground.value),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: screenWidth(30),
                                      top: screenWidth(50)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                          textAlign: TextAlign.center,
                                          TextSpan(children: [
                                            TextSpan(
                                                text: '5%\n',
                                                style: TextStyle(
                                                    height: 1.1,
                                                    color: AppColors
                                                        .mainBlackColor,
                                                    fontSize: controller
                                                        .discountPercentFontSize
                                                        .value,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextSpan(
                                                text: 'Discount',
                                                style: TextStyle(
                                                    color: AppColors
                                                        .mainBlackColor,
                                                    height: 0.4,
                                                    fontSize: controller
                                                        .discountFontSize.value,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            //  CustomTe
                                          ])),
                                      if (controller.showQrCode.value) ...[
                                        screenWidth(60).ph,
                                        Image.asset(
                                          'assets/images/qr_code.png',
                                        )
                                      ],
                                      !controller.showQrCode.value
                                          ? screenWidth(15).ph
                                          : screenWidth(60).ph,
                                      CustomText(
                                          textType: TextStyleType.CUSTOM,
                                          fontSize: screenWidth(40),
                                          fontWeight: FontWeight.w600,
                                          textColor: AppColors.mainWhiteColor,
                                          text: tr('from')),
                                      CustomText(
                                          textType: TextStyleType.CUSTOM,
                                          fontSize: screenWidth(51),
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.mainWhiteColor,
                                          text: tr('limit_lb')),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      // screenWidth(10).ph,
                      CustomIconText(
                        text: tr('invite_friends_lb'),
                        imagename: AppAssets.icAddUser,
                        imageHeight: screenWidth(18),
                        imageWidth: screenWidth(18),
                      ),

                      CustomIconText(
                        onTap: () {
                          {
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  true, // set to false if you want to force a rating
                              builder: (context) => rateDialog,
                            );
                          }
                        },
                        text: tr('rate_us_lb'),
                        imagename: AppAssets.icRate,
                        imageHeight: screenWidth(18),
                        imageWidth: screenWidth(18),
                      ),
                      CustomIconText(
                        text: tr('feedback_lb'),
                        imagename: AppAssets.icSupport,
                        imageHeight: screenWidth(18),
                        imageWidth: screenWidth(18),
                      ),
                      CustomIconText(
                        text: tr('about_us_lb'),
                        imagename: AppAssets.icAbout,
                        imageHeight: screenWidth(18),
                        imageWidth: screenWidth(18),
                      ),
                      CustomIconText(
                        onTap: () {
                          buildAwsomeDialog(
                            context: context,
                            content: tr('logout_warning_dialog'),
                            secondBtnText: tr('logout_lb'),
                            firstBtnText: tr('cancel_lb'),
                            secondBtn: () {
                              Get.offAll(const LoginView());
                              Future.delayed(const Duration(seconds: 1),
                                  () => UserRepository().clearUserData());
                            },
                          );
                        },
                        text: tr('logout_lb'),
                        imagename: AppAssets.icSignOut,
                        imageHeight: screenWidth(18),
                        imageWidth: screenWidth(18),
                      ),
                    ],
                  );
                }),
              ),
            )));
  }
}
