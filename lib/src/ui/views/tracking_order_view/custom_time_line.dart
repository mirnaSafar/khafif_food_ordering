// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_controller.dart';
import 'package:timelines/timelines.dart';

class CustomTimeLine extends StatelessWidget {
  final bool isFirst, isLast, isPast;
  final String svg;
  final CustomerCartModel cart;
  CustomTimeLine({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.svg,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    String? formattedPickUpDatetime =
        cart.pickUpDatetime!.isNotEmpty && cart.deliveryOrderId!.isEmpty
            ? dateTimeController.parse24TimeToDayPeriod(
                stringDateTime: cart.pickUpDatetime!)
            : null;
    String? formattedDateOrder = cart.dateOrder!.isNotEmpty
        ? dateTimeController.parse24TimeToDayPeriod(
            stringDateTime: cart.dateOrder!)
        : null;
    RxInt currentState = (cart.state! == 'Quotation'
            ? 0
            : cart.state! == 'Quotation Sent'
                ? 1
                : cart.state == 'Sales Order'
                    ? 3
                    : 2)
        .obs;
    List<Map<String, String>> nodeData = [
      {
        "text": tr('order_sent_lb'),
        "subtitle":
            formattedPickUpDatetime?.split(' ')[0] ?? formattedDateOrder ?? '',
        "time":
            '${formattedPickUpDatetime?.split(' ')[1] ?? ''} ${formattedPickUpDatetime?.split(' ')[2] ?? ''}',

        //  / '${formattedDateOrder?.split(' ')[1] ?? ''} ${formattedDateOrder?.split(' ')[2] ?? ''}',
        "svg": AppAssets.icOrderSent,
      },
      {
        "text": tr('order_accept_lb'),
        "subtitle": tr('staff_pickup_lb'),
        "time": '',
        // '${formattedPickUpDatetime?.split(' ')[1] ?? ''} ${formattedPickUpDatetime?.split(' ')[2] ?? ''}',
        "svg": AppAssets.icPickup,
      },
      {
        "text": formattedPickUpDatetime != null
            ? tr('order_ready_lb')
            : tr('sending_order_lb'),
        "subtitle": formattedPickUpDatetime != null
            ? tr('order_ready_to_pick_up')
            : tr("shipping_lb"),
        "time": '',
        "svg": formattedPickUpDatetime != null
            ? AppAssets.icOrderAccept
            : AppAssets.icSendingOrder,
      },
      {
        "text": tr('delivered_lb'),
        "subtitle": formattedPickUpDatetime != null
            ? tr('order_picked_up_successfully')
            : tr('delivered_cuccessfully_lb'),
        "time": '12:35 PM',
        "svg": AppAssets.icWaitingClock,
      },
    ];
    // Determine the data for the specific node

    return SizedBox(
      height: context.screenHeight(1),
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: const Color(0xff989898),
          connectorTheme: const ConnectorThemeData(
            // color: isLast
            //     ? Colors.grey.shade300
            //     : AppColors.secondaryblackColor, // Color of the lines
            indent: 1,
            space: 10,
            // thickness: 2,
            // dashArray:  <double>[5, 3],  // Specifies dashes and spaces
          ),
          indicatorTheme: IndicatorThemeData(
            position: 0.5,
            size: context.screenWidth(9.0),
            color: Colors.black, // Color of the lines
          ),
        ),
        builder: TimelineTileBuilder.connected(
          // lastConnectorBuilder: (context) {

          //   return DotIndicator(
          //       color: Colors.grey.shade300,
          //       child: Transform.scale(
          //           scale: 0.5,
          //           child: SvgPicture.asset(AppAssets.icWaitingClock)));
          // },
          indicatorBuilder: (context, index) {
            Color indicatorColor = index > currentState.value
                ? Colors.grey.shade300
                : Colors.orange.withOpacity(0.7);

            return CustomContainer(
              shadowColor: AppColors.shadowColor,
              borderRadius: BorderRadius.circular(100),
              blurRadius: 4,
              offset: const Offset(0, 4),
              child: DotIndicator(
                  color: indicatorColor,
                  child: Transform.scale(
                      scale: 0.5,
                      child: SvgPicture.asset(nodeData[index]["svg"]!))),
            );
          },
          contentsBuilder: (context, index) {
            // Data for title, subtitle, and time
            String? text = nodeData[index]["text"];
            String? subtitle = nodeData[index]["subtitle"];
            String? time = nodeData[index]["time"];
            // Build UI for the node
            return Padding(
              padding:
                  EdgeInsetsDirectional.only(start: context.screenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomText(
                        text: text!,
                        textType: TextStyleType.BODY,
                        textColor: index > currentState.value
                            ? AppColors.greyTextColor
                            : null,
                        fontWeight: FontWeight.w600,
                        // style:  TextStyle(fontSize: f, color: Colors.grey),
                      ),
                      CustomText(
                        text: subtitle!,
                        textType: TextStyleType.BODYSMALL,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.greyTextColor,
                        // style:  TextStyle(fontSize: f, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (index != 3)
                    CustomText(
                      fontWeight: FontWeight.w500,
                      text: time!,
                      textType: TextStyleType.BODYSMALL,
                      // style:  TextStyle(fontSize: f, color: Colors.grey),
                    ),
                ],
              ),
            );
          },
          connectorBuilder: (_, index, type) {
            return SizedBox(
              height: context.screenWidth(15),
              child: DashedLineConnector(
                color: index > currentState.value - 1
                    ? Colors.grey.shade300
                    : AppColors.mainBlackColor,
                dash: 5,
                gap: 2,
                space: 0,
              ),
            ); // Using SolidLineConnector for all lines
          },
          itemCount: 4, // Number of nodes
        ),
      ),
    );
  }
}
