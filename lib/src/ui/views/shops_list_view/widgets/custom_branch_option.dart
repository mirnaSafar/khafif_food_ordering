import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';

// ignore: must_be_immutable
class CustomBranchOption extends StatefulWidget {
  CustomBranchOption(
      {super.key,
      required this.displayOptionText,
      required this.index,
      this.onTap});
  final String displayOptionText;
  int index;
  final Function()? onTap;

  @override
  State<CustomBranchOption> createState() => _CustomBranchOptionState();
}

class _CustomBranchOptionState extends State<CustomBranchOption> {
  ShopsController controller = Get.put(ShopsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.selectedBranchesDisplayOption.value = widget.index;

          widget.onTap?.call();
        },
        child: CustomContainer(
            containerStyle: ContainerStyle.CYLINDER,
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth(30),
                vertical: context.screenWidth(90)),
            shadowColor: Get.theme.colorScheme.primary,
            backgroundColor:
                controller.selectedBranchesDisplayOption.value == widget.index
                    ? AppColors.mainAppColor
                    : Get.theme.colorScheme.primary,
            child: CustomText(
                darkTextColor:
                    // controller.selectedBranchesDisplayOption.value ==
                    //         widget.index
                    AppColors.mainWhiteColor,
                // : AppColors.mainAppColor,
                textColor: controller.selectedBranchesDisplayOption.value ==
                        widget.index
                    ? AppColors.mainWhiteColor
                    : Get.theme.colorScheme.secondary,
                text: widget.displayOptionText,
                textType: TextStyleType.BODY)),
      );
    });
  }
}
