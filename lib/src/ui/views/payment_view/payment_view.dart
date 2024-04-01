import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/checkout_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/custom_payment_method.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/custom_payment_section.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  CheckOutController controller = Get.put(CheckOutController());
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      onPopInvoked: (didPop) {
        Get.find<CartController>().getCart();
        // Get.delete<CartController>();

        // Get.put(CartController(customerCart: cartService.cart.value!.obs));
      },
      child: Scaffold(
        appBar: CustomAppbar(
          appbarTitle: tr('payment_lb'),
        ),
        body: SingleChildScrollView(
          child: Obx(() {
            print(controller.operationType);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(30)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenWidth(25).ph,
                    CustomText(
                        text: tr('payment_method_lb'),
                        textType: TextStyleType.SUBTITLE,
                        fontWeight: FontWeight.w600),
                    screenWidth(15).ph,
                    controller.isPaymentsLoading.value
                        ? paymentMethodsShimmer()
                        : CustomListView(
                            itemCount: controller.paymentMethods.length,
                            separatorPadding: screenWidth(30).ph,
                            vertical: true,
                            listViewHeight: screenHeight(2.3),
                            // backgroundColor: Colors.white,
                            itemBuilder: (context, index) =>
                                CustomPaymentMethod(
                                    value: index,
                                    selected: controller.selectedItem.value,
                                    onTaped: (value) {
                                      setState(() {
                                        controller.selectedItem.value =
                                            value; // Update the selected item
                                      });
                                    },
                                    text:
                                        controller.paymentMethods[index].name ??
                                            '',
                                    image: CustomNetworkImage(
                                        imageUrl: controller
                                                .paymentMethods[index].image ??
                                            ''))),
                    screenWidth(20).ph,
                    CustomText(
                        text: tr('subtotal_lb'),
                        textType: TextStyleType.SUBTITLE,
                        fontWeight: FontWeight.w600),
                    screenWidth(30).ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: tr('delivery_amount_lb'),
                          textType: TextStyleType.BODYSMALL,
                          textColor: AppColors.greyColor,
                          // textColor: AppColors.bodyTextColor,
                        ),
                        CustomText(
                          text: '${controller.deliverAmount} SAR',
                          textType: TextStyleType.BODY,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('subtotal_lb'),
                      pricetext:
                          '${cartController.customerCart!.value.amountUntaxed}',
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('vat_lb'),
                      pricetext: cartController.customerCart!.value.amountTax!
                          .toString(),
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('total_include_lb'),
                      pricefontweight: FontWeight.w700,
                      pricetext:
                          '${cartController.customerCart!.value.amountTotal}',
                      titletextcolor: AppColors.mainBlackColor,
                    ),
                    screenWidth(14).ph,
                    CustomButton(
                        onPressed: () {
                          controller.checkout();
                        },
                        text: tr('place_order_lb')),
                  ]),
            );
          }),
        ),
      ),
    ));
  }

  CustomListView paymentMethodsShimmer() {
    return CustomListView(
        itemCount: 4,
        separatorPadding: screenWidth(30).ph,
        vertical: true,
        listViewHeight: screenHeight(2.3),
        itemBuilder: (context, index) => CustomShimmer(
              isLoading: true,
              child: Container(
                height: screenWidth(5),
                color: AppColors.mainWhiteColor,
              ),
            ));
  }
}
