// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/cart_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/widgets/custom_cart_item.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custum_rich_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/payment_view/payment_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_view.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/order_options_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/views/tracking_order_view/tracking_order_view.dart';

class ConfirmOrderView extends StatefulWidget {
  ConfirmOrderView({super.key, this.showMyOrderCart = false});
  final bool? showMyOrderCart;
  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
              print(controller.selectedCart.value);
              return FutureBuilder(
                  future: whenNotZero(
                    Stream<double>.periodic(Duration(milliseconds: 50),
                        (x) => MediaQuery.of(context).size.width),
                  ),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenWidth(30)),
                          child: Column(
                            children: [
                              if (widget.showMyOrderCart!) ...[
                                context.screenWidth(20).ph,
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: CustomRichText(
                                    firstText: tr('order_no_lb'),
                                    secondText:
                                        controller.customerCart?.value.number ??
                                            '',
                                    firstFontWeight: FontWeight.w400,
                                    secondFontWeight: FontWeight.w700,
                                    firstFontSize: AppFonts(context).title,
                                    secondFontSize: AppFonts(context).title,
                                  ),
                                ),
                              ],
                              context.screenWidth(20).ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.isCartLoading.value
                                      ? totalShimmer()
                                      : CustomText(
                                          text:
                                              '${controller.customerCart?.value.amountTotal ?? 0.0} SAR',
                                          fontWeight: FontWeight.w600,
                                          textType: TextStyleType.HEADER,
                                        ),
                                  context.screenWidth(40).px,
                                  Row(
                                    children: [
                                      if (!widget.showMyOrderCart!)
                                        btnCart(
                                          onPressed: () {
                                            controller.selectedCart.value
                                                        .productUomQty! >
                                                    1
                                                ? controller.updateOrder(
                                                    incress: false)
                                                : null;
                                          },
                                          plusBtn: false,
                                        ),
                                      context.screenWidth(40).px,
                                      controller.isCartLoading.value
                                          ? totalCountShimmer()
                                          : CustomText(
                                              text: controller.orderCount.value,
                                              fontWeight: FontWeight.w600,
                                              textType: TextStyleType.SUBTITLE,
                                            ),
                                      context.screenWidth(40).px,
                                      if (!widget.showMyOrderCart!)
                                        btnCart(
                                            onPressed: () {
                                              if (controller.customerCart !=
                                                  null) {
                                                controller.customerCart!.value
                                                        .line!.isNotEmpty
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
                              ).paddingOnly(bottom: context.screenWidth(30)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: tr('selected_items_lb'),
                                    textType: TextStyleType.BODY,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // if (!widget.showMyOrderCart!)
                                  //   InkWell(
                                  //     onTap: () {
                                  //       if (controller.customerCart != null) {
                                  //         controller.customerCart!.value.line!.isNotEmpty
                                  //             ? warninDialog(
                                  //                 content:
                                  //                     tr('delete_all_items_from_cart_lb'),
                                  //                 okBtn: () {
                                  //                   controller.clearCart();
                                  //                 },
                                  //                 context: context)
                                  //             : null;
                                  //       }
                                  //     },
                                  //     child: CustomText(
                                  //       decoration: TextDecoration.underline,
                                  //       text: tr('remove_all_lb'),
                                  //       textType: TextStyleType.BODY,
                                  //       textColor: AppColors.greyUnderlineText,
                                  //       fontWeight: FontWeight.w400,
                                  //     ),
                                  //   )
                                ],
                              ).paddingOnly(
                                bottom: context.screenWidth(30),
                              ),
                              SizedBox(
                                height: context.screenHeight(1.6),
                                child: controller.isCartLoading.value
                                    ? cartProductsShimmer()
                                    : ListView(
                                        shrinkWrap: true,
                                        children: [
                                          if (controller.customerCart != null)
                                            ...controller
                                                .customerCart!.value.line!
                                                .map(
                                              (cart) {
                                                // var index =    if (controller.customerCart != null) controller.customerCart!.value.line!.indexOf(cart);
                                                return InkWell(
                                                  onTap: () {
                                                    controller.setOderCount =
                                                        cart.productUomQty!
                                                            .toInt();
                                                    controller.selectedCart
                                                        .value = cart;
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: context
                                                                .screenWidth(
                                                                    30)),
                                                    child: CartItem(
                                                        cartModel: cart,
                                                        showMyOrderCart: widget
                                                            .showMyOrderCart),
                                                  ),
                                                );
                                              },
                                            ),
                                          Divider(
                                            height: context.screenWidth(16),
                                            color: AppColors.greyTextColor,
                                          ),
                                          context.screenWidth(20).ph,
                                          if (!widget.showMyOrderCart!)
                                            Obx(() {
                                              print(controller
                                                  .selectedCart.value);
                                              return CustomListView(
                                                itemCount: controller
                                                    .suggestedProducts.length,
                                                listViewHeight:
                                                    context.screenHeight(5.5),
                                                separatorPadding:
                                                    context.screenWidth(30).px,
                                                itemBuilder: (context, index) {
                                                  return CustomContainer(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: context
                                                          .screenWidth(30),
                                                      vertical:
                                                          context.screenWidth(
                                                        60,
                                                      ),
                                                    ),
                                                    width: context
                                                        .screenWidth(3.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    backgroundColor: AppColors
                                                        .mainWhiteColor,
                                                    blurRadius: 4,
                                                    shadowColor:
                                                        AppColors.shadowColor,
                                                    offset: Offset(0, 4),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      children: [
                                                        // Align(
                                                        //   alignment:
                                                        //       Alignment.center,
                                                        //   // top: context
                                                        //   //     .screenWidth(45),
                                                        //   // start: context
                                                        //   //     .screenWidth(25),
                                                        //   child:
                                                        //       CustomNetworkImage(
                                                        //     imageUrl: controller
                                                        //             .suggestedProducts[
                                                        //                 index]
                                                        //             .image ??
                                                        //         '',
                                                        //     height: context
                                                        //         .screenWidth(8),
                                                        //     width: context
                                                        //         .screenWidth(8),
                                                        //   ),
                                                        // ),
                                                        // context .screenWidth(80).ph
                                                        PositionedDirectional(
                                                          bottom: 0,
                                                          start: 0,
                                                          // top: context
                                                          // .screenWidth(8),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                CustomNetworkImage(
                                                                  imageUrl: controller
                                                                          .suggestedProducts[
                                                                              index]
                                                                          .image ??
                                                                      '',
                                                                  height: context
                                                                      .screenWidth(
                                                                          8),
                                                                  width: context
                                                                      .screenWidth(
                                                                          8),
                                                                ),
                                                                context
                                                                    .screenWidth(
                                                                        30)
                                                                    .ph,
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: context
                                                                          .screenWidth(
                                                                              4),
                                                                      height: context
                                                                          .screenWidth(
                                                                              20),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            CustomText(
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          text: controller.suggestedProducts[index].name ??
                                                                              '',
                                                                          darkTextColor:
                                                                              AppColors.mainBlackColor,
                                                                          textType:
                                                                              TextStyleType.SMALL,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    context
                                                                        .screenWidth(
                                                                            200)
                                                                        .ph,
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          'assets/images/fire.png',
                                                                          width:
                                                                              context.screenWidth(30),
                                                                          height:
                                                                              context.screenWidth(30),
                                                                        ),
                                                                        context
                                                                            .screenWidth(80)
                                                                            .px,
                                                                        CustomText(
                                                                            darkTextColor:
                                                                                AppColors.mainBlackColor,
                                                                            textType: TextStyleType.CUSTOM,
                                                                            fontSize: context.screenWidth(40),
                                                                            fontWeight: FontWeight.w400,
                                                                            textColor: AppColors.greyUnderlineText,
                                                                            text: '${controller.suggestedProducts[index].calories} Calories'),
                                                                      ],
                                                                    ),
                                                                    context
                                                                        .screenWidth(
                                                                            100)
                                                                        .ph,
                                                                    CustomRichText(
                                                                      firstColor:
                                                                          AppColors
                                                                              .greyUnderlineText,
                                                                      firstFontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      firstFontSize:
                                                                          context
                                                                              .screenWidth(40),
                                                                      firstText:
                                                                          tr('price_lb'),
                                                                      secondText:
                                                                          '${controller.suggestedProducts[index].price} SAR',
                                                                      secondColor:
                                                                          AppColors
                                                                              .mainBlackColor,
                                                                      secondFontSize:
                                                                          context
                                                                              .screenWidth(40),
                                                                      secondFontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .suggestedProductsIndex
                                                                .value = index;
                                                            Get.delete<
                                                                ProductDetailsController>();

                                                            Get.to(
                                                                ProductDetailsView(
                                                                  suggested:
                                                                      true,
                                                                  product: controller
                                                                          .suggestedProducts[
                                                                      index],
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        500),
                                                                transition:
                                                                    Transition
                                                                        .leftToRight);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            AppAssets
                                                                .icPlusContainer,
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
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  });
            }),
            PositionedDirectional(
              bottom: context.screenWidth(20),
              start: context.screenWidth(30),
              end: context.screenWidth(30),
              child: CustomButton(
                onPressed: () {
                  if (!widget.showMyOrderCart!) {
                    controller.customerCart == null
                        ? warninDialogWithoutAction(
                            context: context,
                            content: tr('empty_cart_waning_lb'),
                          )
                        : controller.customerCart!.value.line!.isNotEmpty
                            ? storage.getOrderDeliveryOptionSelected() == 0
                                ? showOrderOptionsDialog(context)
                                : Get.to(PaymentView())
                            : warninDialogWithoutAction(
                                context: context,
                                content: tr('empty_cart_waning_lb'),
                              );
                  } else {
                    Get.to(() => TrackingOrderView(
                        updateCart: (widget.showMyOrderCart!) ? false : true,
                        cartModel: controller.customerCart!.value));
                  }
                },
                text: !widget.showMyOrderCart!
                    ? tr('confirm_order_lb')
                    : tr('tracking_order_lb'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SnackBar selectOrderOptionWarning(BuildContext context) {
  //   final snackBar = SnackBar(
  //       content: Text(tr("action_needed_lb")),
  //       action: SnackBarAction(
  //           textColor: Get.theme.scaffoldBackgroundColor,
  //           label: tr('select_order_delivery_warning_lb'),
  //           onPressed: () {
  //             showOrderOptionsDialog(context);
  //           }));

  //   return snackBar;
  // }

  Widget btnCart(
      {required bool plusBtn,
      Color? btnColor,
      required void Function()? onPressed}) {
    return SizedBox(
      height: context.screenHeight(23),
      width: context.screenHeight(23),
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
