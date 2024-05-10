// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custum_rich_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/tracking_order_view/custom_time_line.dart';
import 'package:khafif_food_ordering_application/src/ui/views/tracking_order_view/tracking_order_controller.dart';

class TrackingOrderView extends StatefulWidget {
  TrackingOrderView(
      {super.key, required this.cartModel, this.updateCart = true});
  final CustomerCartModel cartModel;
  final bool? updateCart;
  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  @override
  Widget build(BuildContext context) {
    OrderStatusController orderStatusController =
        Get.put(OrderStatusController(widget.cartModel.obs));

    return PopScope(
      onPopInvoked: (didPop) {
        widget.updateCart! ? Get.find<CartController>().getCart() : null;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppbar(
            appbarTitle: tr('tracking_order_lb'),
          ),
          body: SingleChildScrollView(
            child: Obx(() {
              print(orderStatusController.updatedCart.value.id);
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth(20),
                    vertical: context.screenWidth(20)),
                child: StreamBuilder<CustomerCartModel>(
                    stream: Stream.fromFuture(whenNotZero(
                      Stream<double>.periodic(const Duration(milliseconds: 50),
                          (x) => MediaQuery.of(context).size.width),
                    )).asyncMap((event) => widget.cartModel),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRichText(
                              firstText: tr('order_no_lb'),
                              secondText: orderStatusController
                                  .updatedCart.value.number!,
                              firstFontWeight: FontWeight.w400,
                              secondFontWeight: FontWeight.w700,
                              firstFontSize: AppFonts(context).title,
                              secondFontSize: AppFonts(context).title,
                            ),
                            // CustomIconText(
                            //   imagename: AppAssets.icLocation,
                            //   text: 'location',
                            //   fontWeight: FontWeight.w400,
                            //   textcolor: AppColors.greyColor,
                            //   textType: TextStyleType.BODYSMALL,
                            //   imageHeight: context.screenWidth(20),
                            //   imageWidth: context.screenWidth(20),
                            // ),
                            Divider(
                              height: context.screenWidth(30),
                              color: AppColors.greyColor,
                            ),
                            context.screenWidth(30).ph,
                            CustomText(
                              text: tr('tracking_order_lb'),
                              textType: TextStyleType.BODY,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.secondaryblackColor,
                            ),
                            context.screenWidth(30).ph,
                            CustomTimeLine(
                              cart: orderStatusController.updatedCart.value,
                              isFirst: true,
                              isLast: false,
                              isPast: true,
                              svg: AppAssets.icOrderAccept,
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
