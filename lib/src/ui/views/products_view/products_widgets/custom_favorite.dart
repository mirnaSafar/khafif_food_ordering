
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';

class CustomFavorite extends StatefulWidget {
  const CustomFavorite({
    super.key,
    required this.product,
    required this.index,
  });
  final ProductTemplateModel product;
  final int index;
  @override
  State<CustomFavorite> createState() => _CustomFavoriteState();
}

class _CustomFavoriteState extends State<CustomFavorite> {
  ProductsViewController controller = Get.put(ProductsViewController());
  RxInt selectedIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          selectedIndex.value = widget.index;
          controller.toggleFavorites(widget.product);
        },
        child: CustomContainer(
          blurRadius: 4,
          shadowColor: AppColors.shadowColor,
          offset: const Offset(0, 4),
          width: screenWidth(12),
          height: screenWidth(12),
          containerStyle: ContainerStyle.CIRCLE, // borderRadius: 17,
          backgroundColor: AppColors.mainWhiteColor,
          child: Transform.scale(
            scale: 0.4,
            child: SvgPicture.asset(
              controller.isFavorite(widget.product)
                  ? AppAssets.icFavorite
                  : AppAssets.icNotFavorite,
              color: AppColors.mainRedColor,
            ),
          ),
        ),
      );
    });
  }
}
