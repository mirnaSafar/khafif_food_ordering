import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:timelines/timelines.dart';

class CustomTimeLine extends StatelessWidget {
  final bool isFirst, isLast, isPast;
  final String svg;
  const CustomTimeLine({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> nodeData = [
      {
        "text": tr('order_accept_lb'),
        "subtitle": '18/07/2023',
        "time": '12:35 PM',
        "svg": AppAssets.icOrderAccept,
      },
      {
        "text": tr('pickup_lb'),
        "subtitle": tr('staff_pickup_lb'),
        "time": '12:35 PM',
        "svg": AppAssets.icPickup,
      },
      {
        "text": tr('sending_order_lb'),
        "subtitle": tr("shipping_lb"),
        "time": '12:35 PM',
        "svg": AppAssets.icSendingOrder,
      },
      {
        "text": tr('delivered_lb'),
        "subtitle": tr('delivered_cuccessfully_lb'),
        "time": '12:35 PM',
        "svg": AppAssets.icWaitingClock,
      },
    ];
    // Determine the data for the specific node

    return SizedBox(
      height: screenHeight(1),
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
            // dashArray: const <double>[5, 3],  // Specifies dashes and spaces
          ),
          indicatorTheme: IndicatorThemeData(
            position: 0.5,
            size: screenWidth(9.0),
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
            Color indicatorColor = index == 3
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
              padding: EdgeInsetsDirectional.only(start: screenWidth(20)),
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
                        textColor: index == 3 ? AppColors.greyTextColor : null,
                        fontWeight: FontWeight.w600,
                        // style: const TextStyle(fontSize: f, color: Colors.grey),
                      ),
                      CustomText(
                        text: subtitle!,
                        textType: TextStyleType.BODYSMALL,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.greyTextColor,
                        // style: const TextStyle(fontSize: f, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (index != 3)
                    CustomText(
                      fontWeight: FontWeight.w500,
                      text: time!,
                      textType: TextStyleType.BODYSMALL,
                      // style: const TextStyle(fontSize: f, color: Colors.grey),
                    ),
                ],
              ),
            );
          },
          connectorBuilder: (_, index, type) {
            return SizedBox(
              height: screenWidth(15),
              child: DashedLineConnector(
                color: index == 2
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

    // TimelineTile(
    //     isFirst: isFirst,
    //     isLast: isLast,
    //     //decorate the lines
    //     beforeLineStyle: LineStyle(color: AppColors.mainAppColor),
    //     // alignment: TimelineAlign.center,

    //     indicatorStyle: IndicatorStyle(
    //       height: 40,
    //       width: 40,
    //       padding: const EdgeInsets.all(8),
    //       // width: 20,
    //       // indicatorXY: 0,
    //       color: AppColors.mainAppColor,
    //       indicator: Container(
    //         // width: 90,
    //         // height: 90,
    //         // padding: const EdgeInsets.all(0),
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: AppColors.mainAppColor,
    //         ),
    //         child: Transform.scale(
    //           scale: 0.5,
    //           child: SvgPicture.asset(
    //             svg,
    //           ),
    //         ),
    //       ),
    //     ),
    //     endChild: Container(
    //       padding: const EdgeInsets.all(40),
    //       child: const Text('Order Placed'),
    //     ),
    //     afterLineStyle: const LineStyle(
    //       color: Colors.green,
    //       thickness: 2,
    //     )

    //     // dashCap: DashCap.round,
    //     // dashArray: const <double>[5, 3],
    //     // decorate the icon

    //     );
   
