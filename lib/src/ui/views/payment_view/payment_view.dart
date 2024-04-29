import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/payment_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/widgets/custom_cart_item.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/checkout_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/custom_payment_method.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/custom_payment_section.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';

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
    return PopScope(
      onPopInvoked: (didPop) {
        cartController.getCart();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: tr('selected_items_lb'),
                          textType: TextStyleType.BODY,
                          fontWeight: FontWeight.w600,
                        ),
                        if (cartController.customerCart!.value.line!.length > 1)
                          InkWell(
                            onTap: () => controller.viewMore.value =
                                !controller.viewMore.value,
                            child: CustomText(
                              text: controller.viewMore.value
                                  ? tr('view_more_lb')
                                  : tr('view_less_lb'),
                              textType: TextStyleType.BODY,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.mainAppColor,
                              darkTextColor: AppColors.mainAppColor,
                            ),
                          ),
                      ],
                    ),
                    screenWidth(25).ph,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.viewMore.value
                          ? 1
                          : cartController.customerCart!.value.line!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Line cart =
                            cartController.customerCart!.value.line![index];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: screenWidth(30)),
                          child: CartItem(
                              cartModel: cart,
                              showMyOrderCart: true,
                              paymentView: true),
                        );
                      },
                      shrinkWrap: true,
                    ),
                    Divider(
                      height: screenWidth(8),
                    ),
                    CustomText(
                      text:
                          '${slectedDeliveryService()!.isPickup! ? tr('pick_up_from_shop_lb') : tr('deliver_to_address_lb')} ',
                      textType: TextStyleType.SUBTITLE,
                      fontWeight: FontWeight.w600,
                    ),
                    screenWidth(25).ph,
                    SizedBox(
                      width: screenWidth(1),
                      child: SingleChildScrollView(
                        child: CustomText(
                            textAlign: TextAlign.start,
                            text: orderMethodVal.value,
                            fontWeight: FontWeight.w600,
                            textType: TextStyleType.BODYSMALL),
                      ),
                    ),
                    Divider(
                      height: screenWidth(8),
                    ),

                    CustomText(
                        text: tr('payment_method_lb'),
                        textType: TextStyleType.SUBTITLE,
                        fontWeight: FontWeight.w600),
                    screenWidth(15).ph,
                    controller.isPaymentsLoading.value
                        ? paymentMethodsShimmer()
                        : CustomListView(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                controller.filteredPaymentModelList.length,
                            separatorPadding: screenWidth(30).ph,
                            vertical: true,
                            listViewHeight: screenHeight(2.7),
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
                                    text: controller
                                            .filteredPaymentModelList[index]
                                            .name ??
                                        '',
                                    image: CustomNetworkImage(
                                        imageUrl: controller
                                                .paymentMethods[index].image ??
                                            ''))),
                    // screenWidth(40).ph,
                    CustomIconText(
                        image: Icon(
                          Icons.discount,
                          size: screenWidth(25),
                        ),
                        fontWeight: FontWeight.w500,
                        text: tr('discount_code_lb'),
                        textType: TextStyleType.BODYSMALL),
                    // screenWidth(50).ph,
                    UserInput(
                      height: screenHeight(18),
                      text: '',
                      borderColor: AppColors.mainBlackColor,
                    ),
                    screenWidth(10).ph,
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
                          text:
                              '${controller.deliverAmount} ${tr('currency_lb')}',
                          textType: TextStyleType.BODY,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('subtotal_lb'),
                      pricetext:
                          '${cartController.customerCart!.value.amountUntaxed} ${tr('currency_lb')}',
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('vat_lb'),
                      pricetext:
                          '${cartController.customerCart!.value.amountTax!} ${tr('currency_lb')}',
                    ),
                    screenWidth(30).ph,
                    CustomPaymentSection(
                      titletext: tr('total_include_lb'),
                      pricefontweight: FontWeight.w700,
                      pricetext:
                          '${cartController.customerCart!.value.amountTotal} ${tr('currency_lb')}',
                      titletextcolor: AppColors.mainBlackColor,
                    ),
                    screenWidth(7).ph,
                    CustomButton(
                        onPressed: () {
                          controller.checkout();
                        },
                        text: tr('place_order_lb')),
                    screenWidth(12).ph,
                  ]),
            );
          }),
        ),
      ),
    );
  }
}
