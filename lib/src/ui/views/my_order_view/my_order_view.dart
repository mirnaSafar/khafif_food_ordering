// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/address_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/my_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/my_order_view/widgets/order_status.dart';

class MyOrderView extends StatefulWidget {
  MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  Widget build(BuildContext context) {
    MyOrderController controller = Get.put(MyOrderController());

    return Scaffold(
      appBar: CustomAppbar(
        appbarTitle: tr('order_lb'),
      ),
      body: SingleChildScrollView(child: Obx(() {
        return controller.myOrdersLoading.value
            ? Padding(
                padding: EdgeInsets.all(context.screenWidth(30)),
                child: addresseShimmer(isLoading: true),
              )
            : FutureBuilder(
                future: whenNotZero(
                  Stream<double>.periodic(const Duration(milliseconds: 50),
                      (x) => MediaQuery.of(context).size.width),
                ),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data! > 0) {
                      return controller.myOrders.isEmpty
                          ? Center(
                              child: CustomText(
                                  text: tr('no_orders_lb'),
                                  textType: TextStyleType.BODY),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.screenWidth(30)),
                              child: Column(
                                children: [
                                  ...controller.myOrders.map(
                                    (order) {
                                      int index =
                                          controller.myOrders.indexOf(order);
                                      return InkWell(
                                        onTap: () {
                                          controller.getMyOrderCart(
                                              orderID: order.id!);
                                        },
                                        child: OrderStatus(
                                            orderNo: order.number ?? "",
                                            orderDate: order.dateOrder ?? '',
                                            orderPrice: order.amount.toString(),
                                            orderStatusEnum: controller
                                                .formattedOrderStatus[index]),
                                      );
                                    },
                                  ),
                                ],
                              ).paddingSymmetric(
                                  horizontal: context.screenWidth(30)),
                            );
                    }
                  }
                  return Container();
                });
      })),
    );
  }
}
