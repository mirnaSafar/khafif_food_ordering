import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/widgets/custum_rich_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/tracking_order_view/custom_time_line.dart';

class TrackingOrderView extends StatefulWidget {
  const TrackingOrderView({super.key, required this.cartModel});
  final CustomerCartModel cartModel;
  @override
  State<TrackingOrderView> createState() => _TrackingOrderViewState();
}

class _TrackingOrderViewState extends State<TrackingOrderView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Get.find<CartController>().getCart();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppbar(
            appbarTitle: tr('tracking_order_lb'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(20), vertical: screenWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    firstText: tr('order_no_lb'),
                    secondText: widget.cartModel.number!,
                    firstFontWeight: FontWeight.w400,
                    secondFontWeight: FontWeight.w700,
                    firstFontSize: AppFonts.title,
                    secondFontSize: AppFonts.title,
                  ),
                  CustomIconText(
                    imagename: AppAssets.icLocation,
                    text: 'location',
                    fontWeight: FontWeight.w400,
                    textcolor: AppColors.greyColor,
                    textType: TextStyleType.BODYSMALL,
                    imageHeight: screenWidth(20),
                    imageWidth: screenWidth(20),
                  ),
                  Divider(
                    height: screenWidth(30),
                    color: AppColors.greyColor,
                  ),
                  screenWidth(30).ph,
                  CustomText(
                    text: tr('tracking_order_lb'),
                    textType: TextStyleType.BODY,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.secondaryblackColor,
                  ),
                  screenWidth(30).ph,

                  //start time line
                  // SizedBox(
                  //   height: 300,
                  //   child: Timeline.tileBuilder(
                  //     builder: TimelineTileBuilder.fromStyle(
                  //       contentsAlign: ContentsAlign.basic,
                  //       connectorStyle: ConnectorStyle.dashedLine,

                  //       // endConnectorStyle: ConnectorStyle.dashedLine,
                  //       contentsBuilder: (context, index) => Padding(
                  //         padding: const EdgeInsets.all(24.0),
                  //         child: Text('Timeline Event $index'),
                  //       ),
                  //       itemCount: 10,
                  //     ),
                  //   ),
                  // ),
                  CustomTimeLine(
                    isFirst: true,
                    isLast: false,
                    isPast: true,
                    svg: AppAssets.icOrderAccept,
                  ), //start time line
                  //middle time line
                  // CustomTimeLine(
                  //     isFirst: false,
                  //     isLast: false,
                  //     svg: AppAssets.icPickup,
                  //     subtitle: tr('staff_pickup_lb'),
                  //     text: tr('pickup_lb'),
                  //     time: '12:35 PM',
                  //     isPast: true), //start time line
                  // //last time line
                  // CustomTimeLine(
                  //     svg: AppAssets.icSendingOrder,
                  //     isFirst: false,
                  //     isLast: true,
                  //     subtitle: tr('shipping_lb'),
                  //     time: '12:35 PM',
                  //     text: tr('sending_order_lb'),
                  //     isPast: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
// import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
// import 'package:timelines/timelines.dart';

// const kTileHeight = 50.0;

// class TrackingOrderView extends StatelessWidget {
//   const TrackingOrderView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         appbarTitle: tr('tracking_order_lb'),
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           final data = _data(index + 1);
//           return Center(
//             child: SizedBox(
//               width: 360.0,
//               child: Card(
//                 margin: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: _OrderTitle(
//                         orderInfo: data,
//                       ),
//                     ),
//                     const Divider(height: 1.0),
//                     _DeliveryProcesses(processes: data.deliveryProcesses),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _OrderTitle extends StatelessWidget {
//   const _OrderTitle({
//     Key? key,
//     required this.orderInfo,
//   }) : super(key: key);

//   final _OrderInfo orderInfo;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'Delivery #${orderInfo.id}',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const Spacer(),
//         Text(
//           '${orderInfo.date.day}/${orderInfo.date.month}/${orderInfo.date.year}',
//           style: const TextStyle(
//             color: Color(0xffb6b2b2),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class _InnerTimeline extends StatelessWidget {
// //   const _InnerTimeline({
// //     required this.messages,
// //   });

// //   final List<_DeliveryMessage> messages;

// //   @override
// //   Widget build(BuildContext context) {
// //     bool isEdgeIndex(int index) {
// //       return index == 0 || index == messages.length + 1;
// //     }

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: FixedTimeline.tileBuilder(
// //         theme: TimelineTheme.of(context).copyWith(
// //           nodePosition: 0,
// //           connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
// //                 thickness: 1.0,
// //               ),
// //           indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
// //                 size: 10.0,
// //                 position: 0.5,
// //               ),
// //         ),
// //         builder: TimelineTileBuilder(
// //           indicatorBuilder: (_, index) =>
// //               !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
// //           startConnectorBuilder: (_, index) => Connector.solidLine(),
// //           endConnectorBuilder: (_, index) => Connector.solidLine(),
// //           contentsBuilder: (_, index) {
// //             if (isEdgeIndex(index)) {
// //               return null;
// //             }

// //             return Padding(
// //               padding: const EdgeInsets.only(left: 8.0),
// //               child: Text(messages[index - 1].toString()),
// //             );
// //           },
// //           itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
// //           nodeItemOverlapBuilder: (_, index) =>
// //               isEdgeIndex(index) ? true : null,
// //           itemCount: messages.length + 2,
// //         ),
// //       ),
// //     );
// //   }
// // }

// _OrderInfo _data(int id) => _OrderInfo(
//       id: id,
//       date: DateTime.now(),
//       driverInfo: const _DriverInfo(
//         name: 'Philipe',
//         thumbnailUrl:
//             'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
//       ),
//       deliveryProcesses: [
//         const _DeliveryProcess(
//           'Package Process',
//           messages: [
//             _DeliveryMessage('8:30am', 'Package received by driver'),
//             _DeliveryMessage('11:30am', 'Reached halfway mark'),
//           ],
//         ),
//         const _DeliveryProcess(
//           'In Transit',
//           messages: [
//             _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
//             _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
//           ],
//         ),
//         const _DeliveryProcess.complete(),
//       ],
//     );

// class _OrderInfo {
//   const _OrderInfo({
//     required this.id,
//     required this.date,
//     required this.driverInfo,
//     required this.deliveryProcesses,
//   });

//   final int id;
//   final DateTime date;
//   final _DriverInfo driverInfo;
//   final List<_DeliveryProcess> deliveryProcesses;
// }

// class _DriverInfo {
//   const _DriverInfo({
//     required this.name,
//     required this.thumbnailUrl,
//   });

//   final String name;
//   final String thumbnailUrl;
// }

// class _DeliveryProcess {
//   const _DeliveryProcess(
//     this.name, {
//     this.messages = const [],
//   });

//   const _DeliveryProcess.complete()
//       : name = 'Done',
//         messages = const [];

//   final String name;
//   final List<_DeliveryMessage> messages;

//   bool get isCompleted => name == 'Done';
// }

// class _DeliveryMessage {
//   const _DeliveryMessage(this.createdAt, this.message);

//   final String createdAt; // final DateTime createdAt;
//   final String message;

//   @override
//   String toString() {
//     return '$createdAt $message';
//   }
// }
