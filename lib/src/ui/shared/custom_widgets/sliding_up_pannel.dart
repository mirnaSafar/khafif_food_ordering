// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidingUpPannel extends StatefulWidget {
  CustomSlidingUpPannel(
      {super.key,
      required this.backgroundBody,
      required this.panel,
      this.openPanelHeight,
      this.closePanelHeight,
      this.panelBuilder,
      this.panelController});
  final Widget backgroundBody;
  final Widget? panel;
  final double? openPanelHeight, closePanelHeight;
  final Widget Function(ScrollController)? panelBuilder;
  final PanelController? panelController;
  @override
  State<CustomSlidingUpPannel> createState() => _CustomSlidingUpPannelState();
}

class _CustomSlidingUpPannelState extends State<CustomSlidingUpPannel> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropColor: AppColors.mainRedColor,
      color: Get.theme.scaffoldBackgroundColor,
      controller: PanelController(),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      panelBuilder: widget.panelBuilder,
      maxHeight: widget.openPanelHeight ?? context.screenHeight(3),
      minHeight: widget.closePanelHeight ?? context.screenHeight(3),
      panel: widget.panel,
      body: widget.backgroundBody,
    );
  }
}
