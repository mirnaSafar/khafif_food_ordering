// import 'package:flutter/material.dart';
// import 'package:khafif_project/core/data/models/product_model.dart';
// import 'package:get/get.dart';

// import '../../../shared/colors.dart';
// import '../../../shared/custom_widgets/custom_text.dart';
// import 'custom_price.dart';

// // ignore: must_be_immutable
// class CustomRadioList extends StatefulWidget {
//   CustomRadioList(
//       {super.key,
//       required this.groupValue,
//       required this.value,
//       required this.text,
//       required this.model,
//       this.dollarsize,
//       this.price,
//       this.priceIsBold,
//       this.pricesize});
//   int groupValue;
//   int value;
//   ProductModel? model;
//   String text;
//   String? price;
//   bool? priceIsBold;
//   double? pricesize;
//   double? dollarsize;

//   @override
//   State<CustomRadioList> createState() => _CustomRadioListState();
// }

// class _CustomRadioListState extends State<CustomRadioList> {
//   @override
//   Widget build(BuildContext context) {
//     // OrderDetailsController controller = Get.put(OrderDetailsController(
//     //   widget.model!,
//     // ));
//     return Obx(
//       () {
//         return SizedBox(
//           width: 300,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Radio(
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     value: widget.value,
//                     groupValue: widget.groupValue,
//                     onChanged: (value) {
//                       // controller.selectedIntegredientValue.value = value ?? -1;
//                       // controller.addToTotal(
//                       //     widget.model!, double.parse(widget.price ?? '0.0'));
//                       // setState(() {
//                       //   widget.groupValue = value ?? -1;
//                       // });
//                     },
//                     visualDensity: VisualDensity(horizontal: 0, vertical: 0),
//                     activeColor: AppColors.radioBackgroundColor,
//                   ),
//                   CustomText(
//                     text: widget.text,
//                     textColor: AppColors.mainBlueColor,
//                   ),
//                 ],
//               ),
//               if (widget.price != null) ...[
//                 CustomPrice(
//                   price: '+ ' + widget.price!,
//                   pricesize: widget.pricesize ?? 14,
//                   dollarsize: widget.dollarsize ?? 7,
//                   bold: widget.priceIsBold ?? false,
//                   color: AppColors.greyColor,
//                 ),
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
