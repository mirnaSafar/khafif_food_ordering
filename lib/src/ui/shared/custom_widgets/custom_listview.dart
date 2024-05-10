// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class CustomListView extends StatefulWidget {
  CustomListView({
    super.key,
    this.listViewHeight,
    required this.itemCount,
    this.vertical = false,
    required this.separatorPadding,
    required this.itemBuilder,
    this.backgroundColor,
    this.items,
    this.borderRadius,
    this.controller,
    this.physics,
  });
  final double? listViewHeight;
  final int itemCount;
  final bool? vertical;
  final SizedBox separatorPadding;
  final Color? backgroundColor;
  final List? items;
  final Widget? Function(BuildContext, int) itemBuilder;
  final dynamic borderRadius;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  @override
  State<CustomListView> createState() => _CustomListViewChildState();
}

class _CustomListViewChildState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),

      // padding: EdgeInsets.symmetric(horizontal: context .screenWidth(100)),

      height: widget.listViewHeight ?? context.screenHeight(6),
      child: ListView.separated(
          physics: widget.physics,
          controller: widget.controller,
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth(400)),
          shrinkWrap: true,
          scrollDirection: !widget.vertical! ? Axis.horizontal : Axis.vertical,
          itemCount: widget.items?.length ?? widget.itemCount,
          separatorBuilder: (BuildContext context, int index) {
            return widget.separatorPadding;
          },
          itemBuilder: widget.itemBuilder),
    );
  }
}
