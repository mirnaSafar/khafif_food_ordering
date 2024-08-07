// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_checkbox_list.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_listview.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/custom_widgets/custom_topping_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/delivery_checker_dialog.dart';

import 'product_details_controller.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView(
      {super.key, required this.product, this.suggested = false});
  final ProductTemplateModel product;
  final bool? suggested;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List<ValueIds> toppings = [];

  int _selectedItem = 0;
  late ProductDetailsController productDetailsController;
  @override
  void initState() {
    productDetailsController =
        Get.put(ProductDetailsController(product: widget.product.obs));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        onPopInvoked: (didPop) {
          widget.suggested! ? Get.find<CartController>().getCart() : null;
        },
        child: Scaffold(
          appBar: CustomAppbar(),
          body: productDetailsController.isShimmerLoader.value
              ? productDetailsShimmer(isLoading: true)
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.screenWidth(20)),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Obx(() {
                        print(productDetailsController.textExpanded.value);

                        return SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  showproductImageDialog(
                                      image: productDetailsController
                                              .productVariantsModel
                                              .value
                                              .image ??
                                          '');
                                },
                                child: SizedBox(
                                  height: context.screenHeight(4),
                                  child: CustomNetworkImage(
                                      imageUrl: productDetailsController
                                              .productVariantsModel
                                              .value
                                              .image ??
                                          ''),
                                ),
                              ),
                            ),
                            context.screenWidth(15).ph,
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: SingleChildScrollView(
                                    child: CustomText(
                                        textAlign: TextAlign.start,
                                        text: productDetailsController
                                                .product!.value.name ??
                                            '',
                                        fontWeight: FontWeight.w600,
                                        textType: TextStyleType.TITLE),
                                  ),
                                ),
                                // context.screenWidth(30).px,
                                // RichText(
                                //   text: TextSpan(children: [
                                //     TextSpan(
                                //         text: '4.5 ',
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodySmall!),
                                //     WidgetSpan(
                                //         alignment: PlaceholderAlignment.middle,
                                //         child: SvgPicture.asset(
                                //           AppAssets.icStar,
                                //           color: AppColors.mainAppColor,
                                //         ))
                                //   ]),
                                // ),
                                // CustomText(
                                //     text: '(100+)    ',
                                //     fontSize: context.screenWidth(50),
                                //     textType: TextStyleType.CUSTOM),
                                // CustomText(
                                //     text: tr('all_reviews_lb'),
                                //     fontWeight: FontWeight.w500,
                                //     textColor: AppColors.mainAppColor,
                                //     textType: TextStyleType.SMALL),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     CustomText(
                            //         text: 'Khafif Popcorn',
                            //         fontWeight: FontWeight.w400,
                            //         textColor: AppColors.greyTextColor,
                            //         textType: TextStyleType.BODY),
                            //     context.screenWidth(40).px,
                            //     RichText(
                            //       text: TextSpan(children: [
                            //         WidgetSpan(
                            //             child: SvgPicture.asset(
                            //           color: Get.theme.colorScheme.secondary,
                            //           AppAssets.icClock,
                            //         )),
                            //         TextSpan(
                            //             text: '  60 min  ',
                            //             style: Get.theme.textTheme.bodyMedium!
                            //                 .copyWith(
                            //                     fontWeight: FontWeight.w600)),
                            //       ]),
                            //     ),
                            //   ],
                            // ),
                            context.screenWidth(20).ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text:
                                      '${productDetailsController.total.value.toInt()} ${tr('currency_lb')}',
                                  fontWeight: FontWeight.w600,
                                  textType: TextStyleType.HEADER,
                                ),
                                context.screenWidth(40).px,
                                Row(
                                  children: [
                                    SizedBox(
                                      height: context.screenHeight(23),
                                      width: context.screenHeight(23),
                                      child: FloatingActionButton(
                                        heroTag: 'btn1',
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color:
                                                    AppColors.btnMinusColor)),
                                        child: Center(
                                            child: SvgPicture.asset(
                                                AppAssets.icMinus)),
                                        onPressed: () {
                                          productDetailsController.changeCount(
                                              incress: false);
                                          productDetailsController.calcTotal(
                                              price: productDetailsController
                                                  .product!.value.price
                                                  .toString());
                                        },
                                      ),
                                    ),
                                    context.screenWidth(40).px,
                                    CustomText(
                                      text:
                                          '${productDetailsController.count < 10 ? '0' : ''}${productDetailsController.count.value} ',
                                      fontWeight: FontWeight.w600,
                                      textType: TextStyleType.SUBTITLE,
                                    ),
                                    context.screenWidth(40).px,
                                    SizedBox(
                                      height: context.screenHeight(23),
                                      width: context.screenHeight(23),
                                      child: FloatingActionButton(
                                        heroTag: 'btn2',
                                        backgroundColor: AppColors.mainAppColor,
                                        child: Center(
                                            child: SvgPicture.asset(
                                                AppAssets.icPlus)),
                                        onPressed: () {
                                          productDetailsController.changeCount(
                                              incress: true);
                                          productDetailsController.calcTotal(
                                              price: productDetailsController
                                                  .product!.value.price
                                                  .toString());
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            context.screenWidth(30).ph,
                            Text(
                              maxLines:
                                  productDetailsController.textExpanded.isFalse
                                      ? 1
                                      : null,
                              style: TextStyle(
                                  // overflow: TextOverflow.ellipsis,
                                  color: AppColors.greyTextColor,
                                  fontWeight: FontWeight.w400),
                              '${productDetailsController.productVariantsModel.value.description} ',
                            ),
                            Visibility(
                              visible: productDetailsController
                                      .product!.value.description!.length >
                                  60,
                              child: InkWell(
                                onTap: () {
                                  productDetailsController.changeReadStatus();
                                },
                                child: CustomText(
                                  textColor: AppColors.mainAppColor,
                                  darkTextColor: AppColors.mainAppColor,
                                  // fontSize: 14,
                                  text: productDetailsController
                                      .readingState.value,
                                  textType: TextStyleType.SMALL,
                                ),
                              ),
                            ),
                            context.screenWidth(30).ph,
                            if (productDetailsController
                                        .product!.value.variantValue !=
                                    null &&
                                productDetailsController.product!.value
                                    .variantValue!.isNotEmpty) ...[
                              CustomListView(
                                  borderRadius: BorderRadius.circular(8),
                                  itemCount: productDetailsController.product!
                                          .value.variantValue?.length ??
                                      0,
                                  separatorPadding: 0.px,
                                  listViewHeight: context.screenHeight(18),
                                  backgroundColor:
                                      Get.theme.colorScheme.background,
                                  itemBuilder: (context, index) =>
                                      CustomCheckBoxList(
                                        index: index,
                                        selectedValue: _selectedItem,
                                        onTap: () {
                                          setState(() {
                                            _selectedItem =
                                                index; // Update the selected item when tapped
                                          });
                                        },
                                        text: productDetailsController
                                                .product!
                                                .value
                                                .variantValue![index]
                                                .attributeId
                                                ?.name ??
                                            '',
                                      )),
                              context.screenWidth(20).ph, // CustomListView(

                              CustomText(
                                text: tr('available_toppings_lb'),
                                textType: TextStyleType.BODY,
                                fontWeight: FontWeight.w600,
                              ),
                              context.screenWidth(30).ph,
                              ...productDetailsController.product!.value
                                  .variantValue![_selectedItem].valueIds!
                                  .map(
                                (topping) {
                                  toppings = productDetailsController
                                      .product!
                                      .value
                                      .variantValue![_selectedItem]
                                      .valueIds!;
                                  // var index = toppings.indexOf(topping);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: context.screenWidth(30)),
                                    child: CustomToppingWidget(
                                        text: topping.name ?? '',
                                        onTaped: (value) {
                                          productDetailsController
                                                  .selectedVariantsItems[
                                              _selectedItem] = value;
                                          productDetailsController
                                              .getProductVariant(
                                                  variantIds:
                                                      productDetailsController
                                                          .selectedVariantsItems
                                                          .where((variant) =>
                                                              variant != -1)
                                                          .toList());
                                          // .insert(index, value)
                                        },
                                        imagename: productDetailsController
                                                .product!.value.image ??
                                            AppAssets.icPopcorn,
                                        price: topping.priceExtra.toString(),
                                        value: topping.id!,
                                        selected: productDetailsController
                                                .selectedVariantsItems[
                                            _selectedItem]),
                                  );
                                },
                              ),
                            ],
                            context.screenWidth(30).ph,
                          ],
                        ));
                      }).paddingOnly(bottom: context.screenWidth(6)),
                      Positioned(
                        bottom: context.screenWidth(20),
                        right: 5,
                        left: 5,
                        child: Obx(() {
                          print(productDetailsController.selectedVariantsItems);
                          return CustomButton(
                            loader: productDetailsController.isCarLoading.value,
                            onPressed: productDetailsController
                                    .productCanbeAddedToCart.value
                                ? () {
                                    storage.isLoggedIn
                                        ? productDetailsController.addToCart(
                                            suggested: widget.suggested!)
                                        : showBrowsingDialogAlert(context);
                                  }
                                : () {
                                    warninDialogWithoutAction(
                                      context: context,
                                      content: tr('select_toppings_lb'),
                                    );
                                    moveToUnselectedTopping();
                                  },
                            text: tr('add_to_cart_lb'),
                          );
                        }),
                      ),
                      // context .screenWidth(30).ph,
                    ],
                  ),
                ),
        ),
      );
    });
  }

  void moveToUnselectedTopping() {
    bool currentToppingIsSelected =
        productDetailsController.selectedVariantsItems[_selectedItem] != -1;
    int? firstToppingUnselectedIndex =
        (productDetailsController.selectedVariantsItems.firstWhereOrNull(
                  (element) => element == -1,
                ) !=
                null)
            ? productDetailsController.selectedVariantsItems
                .indexWhere((element) => element == -1)
            : null;
    if (currentToppingIsSelected) {
      setState(() {
        _selectedItem = firstToppingUnselectedIndex ?? _selectedItem;
      });
    }
  }
}

prodectAddToCartMessage({required bool suggested}) {
  CustomToast.AwesomeDialog(
    message: tr('added_to_cart'),
    messageType: MessageType.SUCCESS,
    firstBtnText: tr('show_cart_lb'),
    firstBtnFunction: () {
      suggested ? Get.context!.pop() : null;

      Get.off(ConfirmOrderView());
    },
    secondBtnText: tr('cancel_lb'),
  );

  // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //   showCloseIcon: true,
  //   backgroundColor: AppColors.mainBlackColor,
  //   dismissDirection: DismissDirection.horizontal,
  //   content: Row(
  //     children: [
  //       Icon(Icons.check, color: Colors.green),
  //       SizedBox(width: 10),
  //       Text(
  //         tr('added_to_cart'),
  //         style: TextStyle(color: Colors.green),
  //       ),
  //     ],
  //   ),
  //   action: SnackBarAction(
  //     textColor: AppColors.mainWhiteColor,
  //     label: tr('show_cart_lb'),
  //     onPressed: () {
  //       suggested ? Get.context!.pop() : null;

  //       Get.off(ConfirmOrderView());
  //     },
  //   ),
  // ));
}
