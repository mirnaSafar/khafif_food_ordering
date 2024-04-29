import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';

class CustomCategoriesWidget extends StatefulWidget {
  const CustomCategoriesWidget(
      {super.key,
      required this.index,
      required this.scrolled,
      this.onTap,
      this.checklist = false,
      this.selectedValue,
      this.scale,
      this.fontsize,
      required this.sliderIndex,
      required this.scrollOffset});
  final int index;
  final int sliderIndex;
  final double? fontsize;
  final double? scale;
  final bool? checklist;
  final bool scrolled;
  final double scrollOffset;

  final int? selectedValue;
  final void Function()? onTap;
  @override
  State<CustomCategoriesWidget> createState() => _CustomCategoriesWidgetState();
}

class _CustomCategoriesWidgetState extends State<CustomCategoriesWidget> {
  ProductsViewController controller = Get.put(ProductsViewController());
  // RxInt current = (-1).obs;
  // int? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(widget.scrolled ? 0 : screenWidth(200)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(900),
              vertical: screenWidth(widget.scrolled ? 100 : 100)),
          child: InkWell(
            onTap: () {
              widget.onTap!();
              controller.produtSelected.value = widget.index;
              controller.changeBackgroundcolor(widget.index);

              // controller.changeItemSize(
              //     index: widget.index, itemHeight: 158, itemWidth: 58);
            },
            child: CustomContainer(
              containerStyle: !widget.scrolled ? ContainerStyle.CYLINDER : null,
              borderRadius: BorderRadius.circular(20),
              backgroundColor: controller.categoryIndex.value == widget.index &&
                      controller.sliderIndex.value == widget.sliderIndex
                  ? AppColors.mainAppColor
                  : AppColors.mainWhiteColor,
              width: screenWidth(widget.scrolled ? 4.5 : 5.5),
              // height: 115,
              padding: EdgeInsets.symmetric(
                  vertical: widget.scrolled ? 0 : screenWidth(50)),
              child: Column(
                mainAxisAlignment: widget.scrolled
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !widget.scrolled,
                    child: Flexible(
                      // fit: FlexFit.loose
                      flex: 4,
                      child: CustomContainer(
                          borderRadius: BorderRadius.circular(100),
                          height: screenWidth(7),
                          width: screenWidth(7),
                          backgroundColor: AppColors.mainWhiteColor,
                          // padding: EdgeInsets.all(screenWidth(40)),
                          child: Transform.scale(
                              scale: 0.7,
                              child: CachedNetworkImage(
                                imageUrl: controller
                                        .carouselItems[widget.sliderIndex]
                                            [widget.index]
                                        .image ??
                                    '',
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ))).paddingOnly(bottom: screenWidth(50)),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(7),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomText(
                          text: controller
                                  .carouselItems[widget.sliderIndex]
                                      [widget.index]
                                  .name ??
                              '',
                          textType: widget.fontsize != null
                              ? TextStyleType.CUSTOM
                              : TextStyleType.BODYSMALL,
                          fontWeight: FontWeight.w600,
                          fontSize: widget.fontsize,
                          darkTextColor: AppColors.mainBlackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
