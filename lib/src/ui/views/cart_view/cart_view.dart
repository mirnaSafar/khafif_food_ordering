// import 'package:flutter/material.dart';
// import 'package:khafif_food_ordering_application/ui/shared/colors.dart';
// import 'package:khafif_food_ordering_application/ui/shared/custom_widgets/custom_button.dart';
// import 'package:khafif_food_ordering_application/ui/shared/custom_widgets/custom_text.dart';
// import 'package:khafif_food_ordering_application/ui/shared/extensions.dart';
// import 'package:khafif_food_ordering_application/ui/shared/utils.dart';
// import 'package:khafif_food_ordering_application/ui/views/cart_view/cart_controller.dart';

// import 'package:get/get.dart';

// class CartView extends StatefulWidget {
//   const CartView({Key? key}) : super(key: key);

//   @override
//   State<CartView> createState() => _CartViewState();
// }

// class _CartViewState extends State<CartView> {
//   CartController controller = Get.put(CartController());
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Obx(
//               () {
//                 return ListView.separated(
//                   shrinkWrap: true,
//                   itemCount: controller.cartList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '', // controller.cartList[index].meal!.name ?? '',
//                               style: TextStyle(fontSize: screenWidth(20)),
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   controller.removeFromCart(
//                                       controller.cartList[index]);
//                                 },
//                                 icon: const Icon(Icons.delete))
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomButton(
//                                 text: '+',
//                                 onPressed: () {
//                                   // controller.changeCount(
//                                   //   model: controller.cartList[index],
//                                   //   incress: true,
//                                   // );
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                   textAlign: TextAlign.center,
//                                   controller.cartList[index].count.toString(),
//                                   style: TextStyle(fontSize: screenWidth(20))),
//                             ),
//                             // Expanded(
//                             //   child: CustomButton(
//                             //     text: '-',
//                             //     onPressed: () {
//                             //       controller.changeCount(
//                             //         incress: false,
//                             //         model: controller.cartList[index],
//                             //       );
//                             //     },
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                         Text(controller.cartList[index].total.toString(),
//                             style: TextStyle(fontSize: screenWidth(20))),
//                       ],
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return Container(
//                       color: AppColors.mainAppColor,
//                       width: screenWidth(1),
//                       height: 2,
//                     );
//                   },
//                 );
//               },
//             ),
//             const CustomText(
//               text: 'calcTotals',
//               fontSize: 18,
//             ),
//             30.ph,
//             Obx(
//               () => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Sub Total:   \t ${cartService.subTotal}',
//                       style: TextStyle(fontSize: screenWidth(20))),
//                   20.ph,
//                   Text('Tax:   \t ${cartService.tax}',
//                       style: TextStyle(fontSize: screenWidth(20))),
//                   20.ph,
//                   Text('Deliver Fee:   \t ${cartService.deliverFees}',
//                       style: TextStyle(fontSize: screenWidth(20))),
//                   20.ph,
//                   Text('Total Sum:   \t ${cartService.total}',
//                       style: TextStyle(fontSize: screenWidth(20))),
//                 ],
//               ),
//             ),
//             30.ph,
//             CustomButton(
//               text: 'checkout',
//               onPressed: () => controller.checkout(),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
