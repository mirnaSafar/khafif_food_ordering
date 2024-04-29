import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {super.key,
      required this.text,
      required this.switcValue,
      this.onChanged});
  final String text;
  final bool switcValue;
  final void Function(bool)? onChanged;
  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomText(
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w500,
          textColor: Theme.of(context).colorScheme.secondary,
          text: widget.text,
          textType: TextStyleType.BODY,
        ),
        Switch(
          activeColor: Colors.white,
          activeTrackColor: AppColors.swithTileActiveColor,
          value: widget.switcValue,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
