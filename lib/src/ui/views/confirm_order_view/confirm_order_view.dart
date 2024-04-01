import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/cart_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/widgets/custom_cart_item.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/widgets/custum_rich_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/payment_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_image.dart';

class ConfirmOrderView extends StatefulWidget {
  const ConfirmOrderView({super.key, this.showMyOrderCart = false});
  final bool? showMyOrderCart;
  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvoked: (didPop) {
          // myOrderController.getMyOrders();
          Get.delete<CartController>();
        },
        child: Scaffold(
          appBar: CustomAppbar(
            appbarTitle: tr('order_lb'),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(30)),
                  child: Column(
                    children: [
                      if (widget.showMyOrderCart!) ...[
                        screenWidth(20).ph,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomRichText(
                            firstText: tr('order_no_lb'),
                            secondText:
                                controller.customerCart?.value.number ?? '',
                            firstFontWeight: FontWeight.w400,
                            secondFontWeight: FontWeight.w700,
                            firstFontSize: AppFonts.title,
                            secondFontSize: AppFonts.title,
                          ),
                        ),
                        screenWidth(20).ph,
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.isCartLoading.value
                              ? totalShimmer()
                              : CustomText(
                                  text:
                                      '${controller.customerCart?.value.amountTotal ?? 0.0} SAR',
                                  fontWeight: FontWeight.w600,
                                  textType: TextStyleType.HEADER,
                                ),
                          screenWidth(40).px,
                          Row(
                            children: [
                              if (!widget.showMyOrderCart!)
                                btnCart(
                                  onPressed: () {
                                    controller.selectedCart.value
                                                .productUomQty! >
                                            1
                                        ? controller.updateOrder(incress: false)
                                        : null;
                                  },
                                  plusBtn: false,
                                ),
                              screenWidth(40).px,
                              controller.isCartLoading.value
                                  ? totalCountShimmer()
                                  : CustomText(
                                      text: controller.orderCount.value,
                                      fontWeight: FontWeight.w600,
                                      textType: TextStyleType.SUBTITLE,
                                    ),
                              screenWidth(40).px,
                              if (!widget.showMyOrderCart!)
                                btnCart(
                                    onPressed: () {
                                      if (controller.customerCart != null) {
                                        controller.customerCart!.value.line!
                                                .isNotEmpty
                                            ? controller.updateOrder(
                                                incress: true)
                                            : null;
                                      }
                                    },
                                    plusBtn: true,
                                    btnColor: AppColors.mainAppColor),
                            ],
                          ),
                        ],
                      ).paddingOnly(bottom: screenWidth(30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: tr('selected_items_lb'),
                            textType: TextStyleType.BODY,
                            fontWeight: FontWeight.w600,
                          ),
                          if (!widget.showMyOrderCart!)
                            InkWell(
                              onTap: () {
                                if (controller.customerCart != null) {
                                  controller
                                          .customerCart!.value.line!.isNotEmpty
                                      ? warninDialog(
                                          content: tr(
                                              'delete_all_items_from_cart_lb'),
                                          okBtn: () {
                                            controller.clearCart();
                                          },
                                          context: context)
                                      : null;
                                }
                              },
                              child: CustomText(
                                decoration: TextDecoration.underline,
                                text: tr('remove_all_lb'),
                                textType: TextStyleType.BODY,
                                textColor: AppColors.greyUnderlineText,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                        ],
                      ).paddingOnly(
                        bottom: screenWidth(30),
                      ),
                      SizedBox(
                        height: screenHeight(1.6),
                        child: controller.isCartLoading.value
                            ? cartProductsShimmer()
                            : ListView(
                                shrinkWrap: true,
                                children: [
                                  if (controller.customerCart != null)
                                    ...controller.customerCart!.value.line!.map(
                                      (cart) {
                                        // var index =    if (controller.customerCart != null) controller.customerCart!.value.line!.indexOf(cart);
                                        return InkWell(
                                          onTap: () {
                                            controller.setOderCount =
                                                cart.productUomQty!.toInt();
                                            controller.selectedCart.value =
                                                cart;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: screenWidth(30)),
                                            child: CartItem(
                                                cartModel: cart,
                                                showMyOrderCart:
                                                    widget.showMyOrderCart),
                                          ),
                                        );
                                      },
                                    ),
                                  Divider(
                                    height: screenWidth(16),
                                    color: AppColors.greyTextColor,
                                  ),
                                  screenWidth(20).ph,
                                  if (!widget.showMyOrderCart!)
                                    Obx(() {
                                      print(controller.selectedCart.value);
                                      return CustomListView(
                                        itemCount:
                                            controller.suggestedProducts.length,
                                        listViewHeight: screenHeight(5.5),
                                        separatorPadding: screenWidth(30).px,
                                        itemBuilder: (context, index) {
                                          return CustomContainer(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth(30),
                                              vertical: screenWidth(
                                                60,
                                              ),
                                            ),
                                            width: screenWidth(3.2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            backgroundColor:
                                                AppColors.mainWhiteColor,
                                            blurRadius: 4,
                                            shadowColor: AppColors.shadowColor,
                                            offset: const Offset(0, 4),
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.topEnd,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller
                                                        .suggestedProductsIndex
                                                        .value = index;
                                                    Get.delete<
                                                        ProductDetailsController>();
                                                    // /Get.delete<CartController>();
                                                    // context.pop();
                                                    // if (storage.getFirstLaunch()) {
                                                    //   context.pop();
                                                    // } else {
                                                    //   Navigator.of(context).popUntil(
                                                    //       (route) => route.isFirst);
                                                    // }
                                                    Get.to(
                                                        ProductDetailsView(
                                                          suggested: true,
                                                          product: controller
                                                                  .suggestedProducts[
                                                              index],
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        transition: Transition
                                                            .leftToRight);

                                                    // Get.offUntil(//     GetPageRoute(
                                                    //       page: () =>
                                                    //           ProductDetailsView(
                                                    //         product: controller
                                                    //                 .suggestedProducts[
                                                    //             index],
                                                    //       ),
                                                    //     ),
                                                    //     ModalRoute.withName('/'));
                                                    // controller
                                                    // .navigateToSuggsetProductDetails();
                                                    // cartService.addToCart(
                                                    //     model: controller
                                                    //         .suggestedProducts[index],
                                                    //     count: 1);
                                                    // controller.setOderCount =
                                                    //     cartService.cartCount.value;
                                                    // controller.getSuggestedProducts();
                                                  },
                                                  child: SvgPicture.asset(
                                                    AppAssets.icPlusContainer,
                                                  ),
                                                ),
                                                PositionedDirectional(
                                                  top: screenWidth(45),
                                                  start: screenWidth(25),
                                                  child: CustomNetworkImage(
                                                    imageUrl: controller
                                                            .suggestedProducts[
                                                                index]
                                                            .image ??
                                                        '',
                                                    height: screenWidth(8),
                                                    width: screenWidth(8),
                                                  ),
                                                ),
                                                // screenWidth(80).ph
                                                PositionedDirectional(
                                                  bottom: 0,
                                                  start: 0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      screenWidth(10).ph,
                                                      SizedBox(
                                                        width: screenWidth(4),
                                                        height: screenWidth(20),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: CustomText(
                                                            textAlign:
                                                                TextAlign.start,
                                                            text: controller
                                                                    .suggestedProducts[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            darkTextColor: AppColors
                                                                .mainBlackColor,
                                                            textType:
                                                                TextStyleType
                                                                    .SMALL,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      screenWidth(200).ph,

                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/fire.png',
                                                            width:
                                                                screenWidth(30),
                                                            height:
                                                                screenWidth(30),
                                                          ),
                                                          screenWidth(80).px,
                                                          CustomText(
                                                              darkTextColor:
                                                                  AppColors
                                                                      .mainBlackColor,
                                                              textType:
                                                                  TextStyleType
                                                                      .CUSTOM,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              textColor: AppColors
                                                                  .greyUnderlineText,
                                                              text:
                                                                  '${controller.suggestedProducts[index].calories} Calories'),
                                                        ],
                                                      ),
                                                      screenWidth(100).ph,
                                                      CustomRichText(
                                                        firstColor: AppColors
                                                            .greyUnderlineText,
                                                        firstFontWeight:
                                                            FontWeight.w400,
                                                        firstFontSize: 10,
                                                        firstText:
                                                            tr('price_lb'),
                                                        secondText:
                                                            '${controller.suggestedProducts[index].price} SAR',
                                                        secondColor: AppColors
                                                            .mainBlackColor,
                                                        secondFontSize: 10,
                                                        secondFontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      // CustomText(
                                                      //   textType: TextStyleType.CUSTOM,
                                                      //   fontSize: 10,
                                                      //   fontWeight: FontWeight.w400,
                                                      //   textColor: AppColors.greyUnderlineText,
                                                      //   text: tr('price_lb'),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                ],
                              ),
                      ),
                    ],
                  ),
                );
              }),
              if (!widget.showMyOrderCart!)
                PositionedDirectional(
                  bottom: screenWidth(20),
                  start: screenWidth(30),
                  end: screenWidth(30),
                  child: CustomButton(
                    onPressed: () {
                      controller.customerCart == null
                          ? showSnackbarText('Cart is Empty!',
                              internetSnack: false, imageName: 'info')
                          : controller.customerCart!.value.line!.isNotEmpty
                              ? Get.to(const PaymentView())
                              : showSnackbarText('Cart is Empty!',
                                  internetSnack: false, imageName: 'info');
                    },
                    text: tr('confirm_order_lb'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnCart(
      {required bool plusBtn,
      Color? btnColor,
      required void Function()? onPressed}) {
    return SizedBox(
      height: screenHeight(23),
      width: screenHeight(23),
      child: FloatingActionButton(
        heroTag: plusBtn,
        backgroundColor: Colors.transparent,
        shape: CircleBorder(
            side: BorderSide(
                color: plusBtn
                    ? AppColors.mainAppColor
                    : AppColors.btnMinusColor)),
        onPressed: () => onPressed!(),
        child: Center(
            child: SvgPicture.asset(
          plusBtn ? AppAssets.icPlus : AppAssets.icMinus,
          color: btnColor,
        )),
      ),
    );
  }
}
