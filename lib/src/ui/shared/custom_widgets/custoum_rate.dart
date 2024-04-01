import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CustomRate extends StatefulWidget {
  const CustomRate({
    super.key,
    this.size,
    this.enableRate = false,
    this.rateValue,
  });
  final double? size;
  final bool? enableRate;

  final double? rateValue;

  @override
  State<CustomRate> createState() => _CustomRateState();
}

class _CustomRateState extends State<CustomRate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // final Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        InkWell(
          onTap: widget.enableRate!
              ? () {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        true, // set to false if you want to force a rating
                    builder: (context) => rateDialog,
                  );
                }
              : null,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.mainAppColor,
                size: widget.size ?? w * 0.03,
              ),
              CustomText(
                text: '4',
                textColor: AppColors.mainAppColor,
                fontSize: widget.size ?? w * 0.03,
                textType: TextStyleType.SMALL,
              )
            ],
          ),
        ),
      ],
    );
  }
}

final rateDialog = RatingDialog(
    enableComment: false,
    initialRating: 4,
    title: Text(
      tr('khafif_rate_title'),
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: AppFonts.body),
    ),
    message: Text(
      tr('khafif_rate_message'),
      textAlign: TextAlign.center,
      style: TextStyle(
          height: 2.2, fontWeight: FontWeight.w400, fontSize: AppFonts.small),
    ),
    submitButtonText: tr('submit_lb'),
    // commentHisnt: tr('cancel_lb'),
    onCancelled: () {},
    submitButtonTextStyle: TextStyle(color: AppColors.greyTextColor),
    onSubmitted: (response) {
      // context.read<RateShopCubit>().setShopRating(
      //       context: context,
      //       newRate: response.rating,
      //       shopId: widget.store!.shopID,
      //       size: size,
      //       userID: globalSharedPreference.getString("ID"),
      //     );
    });
