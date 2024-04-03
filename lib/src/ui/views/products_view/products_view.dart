import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_carousel_slider.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/no_connection_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/shimmers/products_view_shimmer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/confirm_order_view/confirm_order_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/notifications_view/notifications_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/categories_shape_navigate.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_image.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/custom_product_widget.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/order_options_widget.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOrderOptionsDialog(context);
    });
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

  Widget redCircleItemsContainChecker({bool visible = false}) {
    return Visibility(
      visible: visible,
      child: PositionedDirectional(
        end: 0,
        child: Container(
          width: screenWidth(50),
          height: screenWidth(50),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainBlackColor),
            borderRadius: BorderRadius.circular(100),
            color: AppColors.notificationCircleRedColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder(
        builder: (ProductsViewController controller) => Scaffold(
          // drawer: ,
          key: scaffoldKey,
          drawer: CustomDrawer(
            scaffoldKey: scaffoldKey,
          ),
          body: Obx(
            () {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future(() {
                      homeRefreshingMethod();
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      screenWidth(20).ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                              // Get.to(const ProfileView());
                            },
                            child: SvgPicture.asset(
                              color: Theme.of(context).colorScheme.secondary,
                              AppAssets.icMenu,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => Get.to(const ConfirmOrderView()),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/shopping-cart.png',
                                      color:
                                          Get.theme.textTheme.bodyLarge!.color,
                                      width: screenWidth(18),
                                      height: screenWidth(18),
                                    ),
                                    redCircleItemsContainChecker(
                                        visible:
                                            (cartService.cart.value != null &&
                                                cartService.cart.value!.line!
                                                    .isNotEmpty)),
                                  ],
                                ),
                              ),
                              screenWidth(30).px,
                              InkWell(
                                onTap: () => Get.to(const NotificationsView()),
                                child: Stack(
                                  children: [
                                    redCircleItemsContainChecker(
                                        visible: notificationService
                                            .notifcationsList.isNotEmpty),
                                    SvgPicture.asset(
                                      color: Get.theme.colorScheme.secondary,
                                      AppAssets.icNotification,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      screenWidth(20).ph,
                      Row(
                        children: [
                          buildSearchField(controller),
                          buildFilterWidget()
                        ],
                      ),
                      // screenHeight(100).ph,
                      !isOnline && controller.products.isEmpty
                          ? const Center(child: NoConnetionWidget())
                          : Expanded(
                              child: CustomScrollView(
                                  controller: scrollController,
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child:
                                          // final scrolled = constraints.scrollOffset > 50;
                                          Column(
                                        children: [
                                          productsVieewController
                                                  .bannerLoading.value
                                              ? bannersShimmer(
                                                  isLoading:
                                                      productsVieewController
                                                          .bannerLoading.value)
                                              : CustomCarouselSlider(
                                                  autoPlay: true,
                                                  scrolled: true,
                                                  // padEnds: false,
                                                  sliderHeight: screenHeight(4),
                                                  itemCount:
                                                      productsVieewController
                                                          .bannerList.length,
                                                  itemBuilder: (context,
                                                          int index,
                                                          int realIndex) =>
                                                      CustomNetworkImage(
                                                          scale: 1,
                                                          imageUrl:
                                                              productsVieewController
                                                                      .bannerList[
                                                                          index]
                                                                      .image ??
                                                                  ''),
                                                ),
                                          // screenHeight(50).ph,
                                        ],
                                      ),
                                    ),
                                    SliverLayoutBuilder(
                                      builder:
                                          (BuildContext context, constraints) {
                                        final scrolled =
                                            constraints.scrollOffset > 20;
                                        // final scaleFactor = 1.0 -
                                        //     (constraints.scrollOffset / 100)
                                        //         .clamp(0.0, 1.0);
                                        return SliverAppBar(
                                          pinned: true,
                                          // scrolledUnderElevation: 2,
                                          // floating: true,
                                          // expandedHeight: screenHeight(
                                          //   scrolled
                                          //       ? 12
                                          //       : lerpDouble(
                                          //           4.2,
                                          //           5,
                                          //           (constraints.scrollOffset /
                                          //                   120)
                                          //               .clamp(0.0, 1.0))!,
                                          // ),
                                          flexibleSpace: FlexibleSpaceBar(
                                            // collapseMode: CollapseMode.pin,
                                            titlePadding: EdgeInsets.only(
                                                top: screenWidth(6)),
                                            centerTitle: true,
                                            expandedTitleScale: 1.000000,
                                            title: CategoriesShapeNavigation(
                                              scrolled: scrolled,
                                              scrollOffset:
                                                  constraints.scrollOffset,
                                            ),
                                            background: Container(
                                              color: Get.theme
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),

                                          //! --- categories slider ---

                                          bottom: PreferredSize(
                                              preferredSize: Size(
                                                  screenWidth(1),
                                                  screenHeight(
                                                    scrolled
                                                        ? 11
                                                        : lerpDouble(
                                                            4.2,
                                                            10,
                                                            (constraints.scrollOffset /
                                                                    50)
                                                                .clamp(
                                                                    0.0, 1.0))!,
                                                  )),
                                              child: Container()),

                                          leadingWidth: screenWidth(1),
                                          leading: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                textColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                textAlign: TextAlign.start,
                                                text: tr('explore_products_lb'),
                                                textType:
                                                    TextStyleType.SUBTITLE,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    // showDeliveryCheckerDialog();
                                                    showOrderOptionsDialog(
                                                        context);
                                                  },
                                                  child: deliveryServices()),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    // SliverPersistentHeader(
                                    //     floating: true,
                                    //     pinned: true,
                                    //     delegate: AnimatedHeaderDelegate()),
                                    SliverGrid(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: screenWidth(20),
                                      ),
                                      //!-- products items
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return Obx(
                                            () => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenWidth(80)),
                                                child: controller
                                                        .isShimmerLoader.value
                                                    ? productsShimmer(
                                                        isLoading: true)
                                                    : CustomProductWidget(
                                                        product: controller
                                                            .products[index],
                                                      )),
                                          );
                                        },
                                        childCount:
                                            controller.isShimmerLoader.value
                                                ? 4
                                                : controller.products.length,
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                        child: Column(
                                      children: [
                                        Visibility(
                                          visible: controller.isLoading.value,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: screenWidth(20)),
                                            child: SpinKitFadingCircle(
                                              size: screenWidth(14),
                                              color: AppColors.mainAppColor,
                                            ),
                                          ),
                                        ),
                                        screenWidth(30).ph,
                                      ],
                                    )),
                                  ]),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  buildSearchField(ProductsViewController controller) {
    double rightRadius =
        storage.getAppLanguage() == LanguageService.enCode ? 0 : 8;
    double leftRadius =
        storage.getAppLanguage() == LanguageService.enCode ? 8 : 0;
    return Expanded(
      child: UserInput(
          height: screenWidth(7.3),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(rightRadius),
            bottomRight: Radius.circular(rightRadius),
            topLeft: Radius.circular(leftRadius),
            bottomLeft: Radius.circular(leftRadius),
          ),
          prefixIcon: Transform.scale(
            scale: 0.5,
            child: SvgPicture.asset(AppAssets.icSearch),
          ),
          onChange: (query) {
            query.isNotEmpty
                ? productsVieewController.searchProducts(query: query)
                : null;
          },
          onSubmitted: (query) {
            query.isNotEmpty
                ? productsVieewController.searchProducts(query: query)
                : null;
          },
          text: tr('search_lb'),
          controller: controller.searchController),
    );
  }

  // Widget fetchNextPage(int id) {
  //   // return
  // }

  CustomContainer deliveryServices() {
    return CustomContainer(
        width: screenWidth(3.5),
        containerStyle: ContainerStyle.CIRCLE,
        padding: EdgeInsets.all(screenWidth(60)),
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
  }
}

buildFilterWidget() {
  return CustomContainer(
    backgroundColor: Get.theme.colorScheme.secondary,
    height: screenHeight(14.5),
    width: screenHeight(15),
    borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(8), bottomEnd: Radius.circular(8)),
    padding: EdgeInsets.all(
      screenWidth(23),
    ),
    child: SvgPicture.asset(
      color: Get.theme.colorScheme.primary,
      AppAssets.icFilter,
      height: screenWidth(80),
      width: screenWidth(80),
    ),
  );
}

class AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrolled = shrinkOffset > 50;
    return CategoriesShapeNavigation(
        scrolled: false, scrollOffset: shrinkOffset);
  }

  @override
  double get maxExtent => 170.0;

  @override
  double get minExtent => 20.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
