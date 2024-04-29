import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_contaitner.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.appbarTitle, this.action});
  final String? appbarTitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: screenWidth(30)),
        child: CustomText(
          textColor: Theme.of(context).colorScheme.secondary,
          text: appbarTitle ?? '',
          textType: TextStyleType.TITLE,
          fontSize: screenWidth(20.5),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        if (action != null) action!,
      ],
      leading: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsetsDirectional.only(
            start: screenWidth(30), top: screenWidth(30)),
        child: InkWell(
          onTap: () {
            context.pop();
          },
          child: CustomContainer(
            backgroundColor: AppColors.mainAppColor,
            width: screenWidth(6),
            height: screenWidth(6),
            padding: EdgeInsetsDirectional.only(start: screenWidth(35)),
            borderRadius: BorderRadius.circular(8),
            child: Icon(
              color: AppColors.mainTextColor,
              Icons.arrow_back_ios,
              size: screenWidth(20),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(screenWidth(1), screenHeight(11));
}
