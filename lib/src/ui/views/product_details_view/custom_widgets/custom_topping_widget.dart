// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_radio.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

// ignore: must_be_immutable
class CustomToppingWidget extends StatefulWidget {
  final String text, imagename, price;
  final double? imagewidth, imageheight;
  int value, selected;
  Function? onTaped;
  CustomToppingWidget(
      {super.key,
      required this.text,
      required this.imagename,
      required this.price,
      this.imagewidth,
      this.imageheight,
      required this.value,
      required this.selected,
      this.onTaped});

  @override
  State<CustomToppingWidget> createState() => _CustomToppingWidgetState();
}

class _CustomToppingWidgetState extends State<CustomToppingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.selected = widget.value;
        if (widget.onTaped != null) widget.onTaped!(widget.value);
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.imagename,
                width: widget.imagewidth ?? context.screenWidth(15),
                height: widget.imageheight ?? context.screenWidth(15),
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
              ),
              context.screenWidth(30).px,
              CustomText(
                text: widget.text,
                textType: TextStyleType.BODYSMALL,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: '+ ${formatPriceToInt(widget.price)}',
                textType: TextStyleType.BODYSMALL,
                fontWeight: FontWeight.w600,
              ),
              context.screenWidth(35).px,
              CustomRadio(
                  value: widget.value,
                  onTaped: (value) {
                    setState(() {
                      widget.selected = value;
                      if (widget.onTaped != null) widget.onTaped!(value);
                    });
                  },
                  selected: widget.selected)
            ],
          ),
        ],
      ),
    );
  }
}
