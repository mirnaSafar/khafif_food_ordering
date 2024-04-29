import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/address_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/addresses_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  AddressCntroller controller = Get.put(AddressCntroller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (AddressCntroller controller) {
      return Scaffold(
        appBar: CustomAppbar(appbarTitle: tr('my_addresses_lb')),
        body: Padding(
          padding: EdgeInsets.all(
            screenWidth(30),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Obx(() {
                  return controller.isAddressesLoading.value
                      ? addresseShimmer(
                          isLoading: controller.isAddressesLoading.value)
                      : userAddresses.isEmpty
                          ? Center(child: Text(tr('no_addresses_lb')))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: userAddresses.map((address) {
                                LatLng destination = LatLng(
                                  address.latitude!,
                                  address.longitude!,
                                );

                                int index = userAddresses.indexOf(address);
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: screenWidth(30)),
                                  child: Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(address.hashCode.toString()),
                                    confirmDismiss: (direction) async {
                                      controller.isDismissed.value = false;
                                      storage.isLoggedIn
                                          ? await buildAwsomeDialog(
                                              context: context,
                                              content: tr(
                                                  'address_remove_warning_lb'),
                                              secondBtnText: tr('delete_lb'),
                                              firstBtnText: tr('cancel_lb'),
                                              secondBtn: () {
                                                controller.isDismissed.value =
                                                    isOnline
                                                        ? true
                                                        : showSnackbarText(
                                                            'no internet');
                                              },
                                              firstBtn: () {
                                                controller.isDismissed.value =
                                                    false;
                                              },
                                            )
                                          : showBrowsingDialogAlert(context);

                                      return controller.isDismissed.value;
                                    },
                                    onDismissed: (direction) {
                                      controller.deleteAddress(
                                          addressID: address.id!, index: index);
                                    },
                                    movementDuration:
                                        const Duration(milliseconds: 2000),
                                    dismissThresholds: const {
                                      DismissDirection.endToStart: 0.08
                                    },
                                    resizeDuration: const Duration(seconds: 1),
                                    behavior: HitTestBehavior.deferToChild,
                                    background: CustomContainer(
                                      containerStyle: ContainerStyle.BIGSQUARE,
                                      blurRadius: 4,
                                      shadowColor: AppColors.shadowColor,
                                      offset: const Offset(0, 4),

                                      width: screenWidth(1),
                                      padding: EdgeInsetsDirectional.only(
                                          end: screenWidth(10)),
                                      // alignment: AlignmentDirectional.centerEnd,
                                      backgroundColor: AppColors.mainRedColor,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.mainWhiteColor,
                                        ),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(MapPage(
                                          newAddress: true,
                                          editAddress: {
                                            "edit": true,
                                            "index": index
                                          },
                                          destination: destination,
                                          closePanelHeight: screenHeight(8),
                                        ));
                                      },
                                      child: CustomContainer(
                                        backgroundColor:
                                            AppColors.mainWhiteColor,
                                        containerStyle:
                                            ContainerStyle.BIGSQUARE,
                                        blurRadius: 4,
                                        shadowColor: AppColors.shadowColor,
                                        offset: const Offset(0, 4),
                                        padding:
                                            EdgeInsets.all(screenWidth(15)),
                                        width: screenWidth(1),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: address.name ?? '',
                                                    textType:
                                                        TextStyleType.BODY,
                                                    darkTextColor: AppColors
                                                        .secondaryblackColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            Get.to(MapPage(
                                                              newAddress: true,
                                                              editAddress: {
                                                                "edit": true,
                                                                "index": index
                                                              },
                                                              destination:
                                                                  destination,
                                                            ));
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                                  AppAssets
                                                                      .icEdit)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: screenWidth(60)),
                                                child: CustomText(
                                                  textAlign: TextAlign.start,
                                                  text: address.street ?? '',
                                                  textType:
                                                      TextStyleType.BODYSMALL,
                                                  darkTextColor:
                                                      AppColors.greyColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              CustomText(
                                                text:
                                                    'IZIP (${address.zip ?? ''})',
                                                textType:
                                                    TextStyleType.BODYSMALL,
                                                darkTextColor:
                                                    AppColors.greyColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .bottomEnd,
                                                child: TextButton(
                                                    onPressed: () {
                                                      Get.put(MapController())
                                                          .checkDeliveryAbility(
                                                        target: LatLng(
                                                          address.latitude!,
                                                          address.longitude!,
                                                        ),
                                                      );
                                                    },
                                                    child: CustomText(
                                                      textAlign: TextAlign.end,
                                                      textColor: AppColors
                                                          .mainAppColor,
                                                      darkTextColor: AppColors
                                                          .mainAppColor,
                                                      text: tr(
                                                          'select_address_lb'),
                                                      textType: TextStyleType
                                                          .BODYSMALL,
                                                    )),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                }),
              ).paddingOnly(bottom: screenWidth(6)),
              Positioned(
                bottom: 5,
                right: 5,
                left: 5,
                child: CustomButton(
                  onPressed: () {
                    Get.to(MapPage(
                      editAddress: const {"edit": false, "index": null},
                      newAddress: true,
                      closePanelHeight: screenHeight(5),
                    ));
                  },
                  text: tr('add_addresse_lb'),
                  imageName: 'add_ic',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Address {
  final String name;
  final String streetName;
  final String izip;
  final LatLng coordinates;
  Address(
      {required this.coordinates,
      required this.streetName,
      required this.name,
      required this.izip});
}
