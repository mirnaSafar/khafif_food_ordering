// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/awosem_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';

class CartItem extends StatelessWidget {
  final double? imagewidth, imageheight;
  final Line cartModel;
  CartItem({
    super.key,
    this.imagewidth,
    this.imageheight,
    required this.cartModel,
    this.showMyOrderCart = false,
    this.paymentView = false,
  });
  final bool? showMyOrderCart;
  final bool? paymentView;

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
              imageUrl: cartModel.productId!.image ?? '',
              width: imagewidth ?? context.screenWidth(15),
              height: imageheight ?? context.screenWidth(15),
            ),
            context.screenWidth(30).px,
            SizedBox(
              width: context.screenWidth(2),
              // height: context .screenWidth(15),
              child: SingleChildScrollView(
                child: CustomText(
                  textAlign: TextAlign.start,
                  text: cartModel.productId!.description ?? '',
                  textType: TextStyleType.BODYSMALL,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: ' ${cartModel.priceUnit?.toInt()} ${tr('currency_lb')}',
                  textType: TextStyleType.BODYSMALL,
                  fontWeight: FontWeight.w600,
                ),
                if (paymentView!)
                  CustomText(
                    text:
                        '${tr('quantity_lb')} ${cartModel.productUomQty!.toInt()}',
                    textType: TextStyleType.SMALL,
                    textColor: AppColors.mainAppColor,
                    darkTextColor: AppColors.mainAppColor,
                    fontWeight: FontWeight.w600,
                  ),
              ],
            ),
            if (!showMyOrderCart!)
              IconButton(
                  onPressed: () {
                    controller.selectedCart.value = cartModel;

                    buildAwsomeDialog(
                      context: context,
                      content: tr('delete_item_from_cart_lb'),
                      firstBtnColor: Colors.red,
                      secondBtnColor: Colors.green,
                      firstBtnText: tr('ok_lb'),
                      secondBtnText: tr('cancel_lb'),
                      firstBtn: () {
                        controller.deleteOrder();
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.canceledRedColor,
                  )),
          ],
        ),
      ],
    );
  }
}
