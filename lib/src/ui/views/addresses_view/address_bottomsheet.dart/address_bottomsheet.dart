// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';

class AddressBottomSheet extends StatelessWidget {
  AddressBottomSheet({super.key, this.onSubmitted, required this.address});
  final void Function(String)? onSubmitted;
  final AddressModel address;
  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController(
      destination: LatLng(
        address.latitude!,
        address.longitude!,
      ),
    ));
    // ShopsController shopsController = Get.put(ShopsController());
    TextEditingController locationController =
        TextEditingController(text: address.name);

    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.screenHeight(18),
      ),
      child: SizedBox(
        // heightcontext .: screenHeight(4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth(20)),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                context.screenHeight(40).ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          onSubmitted!(locationController.text);

                          Navigator.pop(context);
                        }
                      },
                      child: CustomIconText(
                          imagecolor: Colors.blue[600],
                          imagename: AppAssets.icLocation,
                          text: tr('save_location_lb')),
                    ),
                    SizedBox(
                      width: context.screenWidth(3),
                      height: context.screenWidth(10),
                      child: CustomButton(
                        text: tr('order_now_lb'),
                        onPressed: () {
                          mapController.checkDeliveryAbility(
                            target: LatLng(
                              address.latitude!,
                              address.longitude!,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                context.screenWidth(20).ph,
                UserInput(
                  validator: (name) {
                    if (name!.isEmpty) {
                      return tr('enter_location_name');
                    }
                    return null;
                  },
                  controller: locationController,
                  onSubmitted: (name) {
                    locationController.text = name;
                    if (formkey.currentState!.validate()) {
                      onSubmitted!(locationController.text);

                      Navigator.pop(context);
                    }
                  },
                  text: tr('location_name_lb'),
                ),
                //  context .screenWidth(30).ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
