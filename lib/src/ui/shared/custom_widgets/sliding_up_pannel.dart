import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidingUpPannel extends StatefulWidget {
  const CustomSlidingUpPannel(
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
      controller: PanelController(),
      borderRadius: BorderRadius.circular(20),
      panelBuilder: widget.panelBuilder,
      maxHeight: widget.openPanelHeight ?? screenHeight(3),
      minHeight: widget.closePanelHeight ?? screenHeight(3),
      panel: widget.panel,
      body: widget.backgroundBody,
    );
  }
}
