// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_user_card.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custoum_rate.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/profile_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/addresses_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_information/my_information.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
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
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppbar(appbarTitle: tr('personal_details_lb')),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: whenNotZero(
                Stream<double>.periodic(Duration(milliseconds: 50),
                    (x) => MediaQuery.of(context).size.width),
              ),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data! > 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.screenWidth(15),
                          ),
                          child: Obx(() {
                            print(controller.showQrCode.value);
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomContainer(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: context.screenWidth(40),
                                        vertical: context.screenWidth(50)),
                                    backgroundColor: AppColors.mainWhiteColor,
                                    containerStyle: ContainerStyle.BIGSQUARE,
                                    blurRadius: 4,
                                    shadowColor: AppColors.shadowColor,
                                    offset: Offset(0, 4),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              Get.to(() => MyInformationView()),
                                          child: Row(
                                            children: [
                                              CustomContainer(
                                                  containerStyle: ContainerStyle
                                                      .SMALLSQUARE,
                                                  backgroundColor:
                                                      AppColors.backgroundColor,
                                                  width: context.screenWidth(5),
                                                  height:
                                                      context.screenWidth(5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: CustomNetworkImage(
                                                      scale: 1.2,
                                                      imageUrl: userinfo
                                                              ?.value?.image ??
                                                          '',
                                                    ),
                                                  )),
                                              context.screenWidth(30).px,
                                              ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tight(Size(
                                                        context
                                                            .screenWidth(3.0),
                                                        context
                                                            .screenWidth(5.5))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: CustomText(
                                                          darkTextColor: AppColors
                                                              .mainBlackColor,
                                                          textType:
                                                              TextStyleType
                                                                  .BODY,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          text: userinfo?.value
                                                                  ?.name ??
                                                              ''),
                                                    ).paddingOnly(bottom: 0),
                                                    CustomText(
                                                      darkTextColor: AppColors
                                                          .mainBlackColor,
                                                      textType:
                                                          TextStyleType.SMALL,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: AppColors
                                                          .mainGreyColor,
                                                      text:
                                                          '${userinfo?.value?.phone!}',
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: CustomText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        darkTextColor: AppColors
                                                            .mainBlackColor,
                                                        textType:
                                                            TextStyleType.SMALL,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textColor: AppColors
                                                            .mainGreyColor,
                                                        text: storage
                                                            .userStreetName,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        context.screenWidth(15).px,
                                        CustomContainer(
                                            padding: EdgeInsets.symmetric(
                                              vertical: context.screenWidth(50),
                                              horizontal:
                                                  context.screenWidth(48),
                                            ),
                                            containerStyle:
                                                ContainerStyle.CIRCLE,
                                            backgroundColor:
                                                AppColors.mainAppColor,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    AppAssets.icStarPoints),
                                                context.screenWidth(100).px,
                                                controller.isUserPointsLoading
                                                        .value
                                                    ? pointsShimmer()
                                                    : SizedBox(
                                                        width: context
                                                            .screenWidth(11),
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: CustomText(
                                                              darkTextColor:
                                                                  AppColors
                                                                      .mainBlackColor,
                                                              textType:
                                                                  TextStyleType
                                                                      .SMALL,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              // textColor: AppColors.mainWhiteColor,
                                                              text: controller
                                                                  .intUserPoints
                                                                  .value),
                                                        ),
                                                      ),
                                              ],
                                            ))
                                      ],
                                    )),
                                context.screenWidth(20).ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomInfoWidget(
                                      text: tr('settings_lb'),
                                      imagename: AppAssets.icSettings,
                                      onTap: () {
                                        Get.to(SettingsView());
                                      },
                                    ),
                                    CustomInfoWidget(
                                      onTap: () {
                                        Get.to(MyInformationView());
                                      },
                                      text: tr('info_lb'),
                                      imagename: AppAssets.icProfileInfo,
                                    ),
                                    CustomInfoWidget(
                                      onTap: () {
                                        Get.to(AddressesView());
                                      },
                                      text: tr('addresses_lb'),
                                      imagename: AppAssets.icAddress,
                                    ),
                                    CustomInfoWidget(
                                      onTap: () {
                                        Get.to(MyOrderView());
                                      },
                                      text: tr('orders_lb'),
                                      imagename: AppAssets.icBox,
                                    ),
                                  ],
                                ),
                                context.screenWidth(15).ph,
                              ],
                            );
                          }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenWidth(40)),
                          child: CustomUserCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenWidth(15),
                              vertical: context.screenWidth(20)),
                          child: Column(
                            children: [
                              CustomIconText(
                                text: tr('invite_friends_lb'),
                                imagename: AppAssets.icAddUser,
                                imageHeight: context.screenWidth(18),
                                imageWidth: context.screenWidth(18),
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
                                imageHeight: context.screenWidth(18),
                                imageWidth: context.screenWidth(18),
                              ),
                              CustomIconText(
                                text: tr('feedback_lb'),
                                imagename: AppAssets.icSupport,
                                imageHeight: context.screenWidth(18),
                                imageWidth: context.screenWidth(18),
                              ),
                              CustomIconText(
                                text: tr('about_us_lb'),
                                imagename: AppAssets.icAbout,
                                imageHeight: context.screenWidth(18),
                                imageWidth: context.screenWidth(18),
                              ),
                              CustomIconText(
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
                                text: tr('logout_lb'),
                                imagename: AppAssets.icSignOut,
                                imageHeight: context.screenWidth(18),
                                imageWidth: context.screenWidth(18),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
                return Container();
              }),
        ));
  }
}
