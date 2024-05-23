// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_carousel_slider.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/no_connection_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/notifications_view/notifications_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/categories_shape_navigate.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_network_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/order_options_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/search_widgets.dart';

class ProductsView extends StatefulWidget {
  ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  ProductsViewController controller = Get.put(ProductsViewController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    locationService.getUserCurrentLocation();
    locationService.getCurrentAddressInfo();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showOrderOptionsDialog(context);
    // });
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        controller.totalPages.value > controller.currentPage.value &&
        controller.isShimmerLoader.isFalse) {
      controller.fetchNextPage(
          id: controller.categoryIndex.value != -1
              ? controller
                  .carouselItems[controller.sliderIndex.value]
                      [controller.categoryIndex.value]
                  .id
              : null);
    }
  }

  Widget redCircleItemsContainChecker(
      {bool visible = false, required int itemsCount}) {
    return Visibility(
      visible: visible,
      child: PositionedDirectional(
        end: -5,
        bottom: 15,
        child: Container(
          width: context.screenWidth(25),
          height: context.screenWidth(25),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainBlackColor),
            borderRadius: BorderRadius.circular(100),
            color: AppColors.mainAppColor,
          ),
          child: CustomText(
            textAlign: TextAlign.center,
            text: itemsCount.toString(),
            textType: TextStyleType.CUSTOM,
            fontSize: context.screenWidth(42),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (ProductsViewController controller) => Scaffold(
        // drawer: ,
        key: scaffoldKey,
        drawer: CustomDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: Obx(
          () {
            print(productsVieewController.current.value);
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth(30)),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future(() {
                    homeRefreshingMethod();
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.screenWidth(8).ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldKey.currentState!.openDrawer();
                            // Get.to( ProfileView());
                          },
                          child: SvgPicture.asset(
                            color: Theme.of(context).colorScheme.secondary,
                            AppAssets.icMenu,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: controller.orderMethodTitle.value,
                              textType: TextStyleType.BODY,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                                width: context.screenWidth(1.5),
                                child: AutoScrollText(
                                  slectedDeliveryService() == null
                                      ? ''
                                      : orderMethodVal.value,
                                  velocity:
                                      Velocity(pixelsPerSecond: Offset(20, 0)),
                                  pauseBetween: Duration(seconds: 1),
                                  mode: AutoScrollTextMode.bouncing,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.to(ConfirmOrderView()),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset(
                                    'assets/images/shopping-cart.png',
                                    color: Get.theme.textTheme.bodyLarge!.color,
                                    width: context.screenWidth(18),
                                    height: context.screenWidth(18),
                                  ),
                                  redCircleItemsContainChecker(
                                      itemsCount: cartService.cartCount.value,
                                      visible:
                                          (cartService.cart.value != null &&
                                              cartService.cart.value!.line!
                                                  .isNotEmpty)),
                                ],
                              ),
                            ),
                            context.screenWidth(30).px,
                            InkWell(
                              onTap: () {
                                productsVieewController
                                    .notificationsCount.value = 0;
                                Get.to(NotificationsView());
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SvgPicture.asset(
                                    color: Get.theme.colorScheme.secondary,
                                    AppAssets.icNotification,
                                  ),
                                  redCircleItemsContainChecker(
                                      itemsCount: productsVieewController
                                          .notificationsCount.value,
                                      visible: productsVieewController
                                              .notificationsCount.value !=
                                          0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context.screenWidth(20).ph,
                    Row(
                      children: [buildSearchField(), buildFilterWidget()],
                    ),
                    context.screenHeight(90).ph,
                    !isOnline && controller.products.isEmpty
                        ? Center(child: NoConnetionWidget())
                        : Expanded(
                            child: productsVieewController.isSearchLoader.value
                                ? searchProductsShimmer(isLoading: true)
                                : productsVieewController
                                            .searchProductsList.isNotEmpty &&
                                        controller
                                            .searchController.text.isNotEmpty
                                    ? searchResultsView()
                                    : productsVieewController
                                                .showNoSearchResult.value &&
                                            controller.searchController.text
                                                .isNotEmpty
                                        ? NoSearchResultsWidget()
                                        : FutureBuilder(
                                            future: whenNotZero(
                                              Stream<double>.periodic(
                                                  const Duration(
                                                      milliseconds: 50),
                                                  (x) => MediaQuery.of(context)
                                                      .size
                                                      .width),
                                            ),
                                            builder: (BuildContext context,
                                                snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data! > 0) {
                                                  return CustomScrollView(
                                                      controller:
                                                          scrollController,
                                                      slivers: [
                                                        SliverToBoxAdapter(
                                                          child:
                                                              // final scrolled = constraints.scrollOffset > 50;
                                                              productsVieewController
                                                                      .bannerLoading
                                                                      .value
                                                                  ? bannersShimmer(
                                                                      isLoading: productsVieewController
                                                                          .bannerLoading
                                                                          .value)
                                                                  : CustomCarouselSlider(
                                                                      autoPlay:
                                                                          true,
                                                                      scrolled:
                                                                          true,
                                                                      // padEnds: false,
                                                                      sliderHeight:
                                                                          context
                                                                              .screenHeight(4),
                                                                      itemCount: productsVieewController
                                                                          .bannerList
                                                                          .length,
                                                                      itemBuilder: (context, int index, int realIndex) => CustomNetworkImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          scale:
                                                                              1.05,
                                                                          imageUrl:
                                                                              productsVieewController.bannerList[index].image ?? ''),
                                                                    ),
                                                        ),
                                                        SliverLayoutBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              constraints) {
                                                            final scrolled =
                                                                constraints
                                                                        .scrollOffset >
                                                                    0;
                                                            // final scaleFactor = 1.0 -
                                                            //     (constraints.scrollOffset / 100)
                                                            //         .clamp(0.0, 1.0);
                                                            return SliverAppBar(
                                                              titleSpacing: context
                                                                  .screenWidth(
                                                                      70),
                                                              pinned: true,
                                                              // scrolledUnderElevation: 2,
                                                              // floating: true,
                                                              // expandedHeight:
                                                              //     context.screenHeight(
                                                              //   scrolled
                                                              //       ? 16
                                                              //       : lerpDouble(
                                                              //           7,
                                                              //           9,
                                                              //           (constraints.scrollOffset /
                                                              //                   120)
                                                              //               .clamp(
                                                              //                   0.0,
                                                              //                   1.0))!,
                                                              // ),
                                                              flexibleSpace:
                                                                  FlexibleSpaceBar(
                                                                // collapseMode: CollapseMode.pin,
                                                                titlePadding: EdgeInsets.only(
                                                                    top: context
                                                                        .screenWidth(
                                                                            4.5)),
                                                                centerTitle:
                                                                    true,
                                                                expandedTitleScale:
                                                                    1.000000,
                                                                title:
                                                                    CategoriesShapeNavigation(
                                                                  scrolled:
                                                                      scrolled,
                                                                  scrollOffset:
                                                                      constraints
                                                                          .scrollOffset,
                                                                ),
                                                                background:
                                                                    Container(
                                                                  color: Get
                                                                      .theme
                                                                      .scaffoldBackgroundColor,
                                                                ),
                                                              ),

                                                              //! --- categories slider ---

                                                              bottom: PreferredSize(
                                                                  preferredSize: Size(
                                                                      context.screenWidth(1),
                                                                      context.screenHeight(
                                                                        scrolled
                                                                            ? 13
                                                                            : 4.2,
                                                                      )),
                                                                  child: Container()),

                                                              leadingWidth: context
                                                                  .screenWidth(
                                                                      1),
                                                              leading: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomText(
                                                                    textColor: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    text: tr(
                                                                        'explore_products_lb'),
                                                                    textType:
                                                                        TextStyleType
                                                                            .SUBTITLE,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // showDeliveryCheckerDialog();
                                                                        splashController.orderDeliveryOptions.isEmpty &&
                                                                                !splashController.isOrderOptionsLoading.value
                                                                            ? splashController.getOrderDeliveryOptions()
                                                                            : splashController.orderDeliveryOptions.isNotEmpty
                                                                                ? showOrderOptionsDialog(context)
                                                                                : null;
                                                                      },
                                                                      child:
                                                                          deliveryServices()),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        SliverToBoxAdapter(
                                                            child: Column(
                                                          children: [
                                                            Visibility(
                                                              visible: controller
                                                                      .productsList
                                                                      .isEmpty &&
                                                                  !controller
                                                                      .isShimmerLoader
                                                                      .value,
                                                              child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: context
                                                                          .screenWidth(
                                                                              20)),
                                                                  child: CustomText(
                                                                      text: tr(
                                                                          'no_products_lb'),
                                                                      textType:
                                                                          TextStyleType
                                                                              .BODYSMALL)),
                                                            ),
                                                            context
                                                                .screenWidth(30)
                                                                .ph,
                                                          ],
                                                        )),
                                                        SliverGrid(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            mainAxisSpacing:
                                                                context
                                                                    .screenWidth(
                                                                        20),
                                                          ),
                                                          //!-- products items
                                                          delegate:
                                                              SliverChildBuilderDelegate(
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                              return Obx(
                                                                () => Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            context.screenWidth(
                                                                                80)),
                                                                    child: controller
                                                                            .isShimmerLoader
                                                                            .value
                                                                        ? productsShimmer(
                                                                            isLoading:
                                                                                true)
                                                                        : CustomProductWidget(
                                                                            product:
                                                                                controller.products[index],
                                                                          )),
                                                              );
                                                            },
                                                            childCount: controller
                                                                    .isShimmerLoader
                                                                    .value
                                                                ? 4
                                                                : controller
                                                                    .products
                                                                    .length,
                                                          ),
                                                        ),
                                                        SliverToBoxAdapter(
                                                            child: Column(
                                                          children: [
                                                            Visibility(
                                                              visible:
                                                                  controller
                                                                      .isLoading
                                                                      .value,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: context
                                                                        .screenWidth(
                                                                            20)),
                                                                child:
                                                                    SpinKitFadingCircle(
                                                                  size: context
                                                                      .screenWidth(
                                                                          14),
                                                                  color: AppColors
                                                                      .mainAppColor,
                                                                ),
                                                              ),
                                                            ),
                                                            context
                                                                .screenWidth(30)
                                                                .ph,
                                                          ],
                                                        )),
                                                      ]);
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                return Container();
                                              }
                                            }),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FutureBuilder<double> deliveryServices() {
    return FutureBuilder(
        future: whenNotZero(
          Stream<double>.periodic(Duration(milliseconds: 50),
              (x) => MediaQuery.of(context).size.width),
        ),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! > 0) {
              return CustomContainer(
                  width: context.screenWidth(3.5),
                  containerStyle: ContainerStyle.CIRCLE,
                  padding: EdgeInsets.all(context.screenWidth(60)),
                  backgroundColor: AppColors.mainAppColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 5.px,
                      CustomText(
                          text: tr("delivery_service"),
                          textColor: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                          textType: TextStyleType.SMALL),
                      // 10.px,

                      SvgPicture.asset(
                        color: Theme.of(context).colorScheme.secondary,
                        AppAssets.icBack,
                      ),
                    ],
                  ));
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }
}
