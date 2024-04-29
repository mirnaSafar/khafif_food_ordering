import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider(
      {super.key,
      this.onPageChanged,
      required this.itemCount,
      this.child,
      this.padEnds,
      this.autoPlay,
      this.enlargeCenterPage,
      this.viewportFraction,
      this.argeFactor,
      this.aspectRatio,
      this.disableCenter,
      this.sliderHeight,
      this.scrolled = false,
      this.itemBuilder,
      this.dotsHeigth,
      this.initialPage = 0});
  final void Function(int index, CarouselPageChangedReason reason)?
      onPageChanged;
  final int itemCount;
  final Widget? child;
  final bool? padEnds;
  final bool? autoPlay;
  final bool? scrolled;
  final bool? enlargeCenterPage;
  final double? viewportFraction;
  final double? argeFactor;
  final double? aspectRatio;
  final bool? disableCenter;
  final double? sliderHeight;
  final double? dotsHeigth;
  final int? initialPage;
  final Widget Function(BuildContext, int, int)? itemBuilder;
  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselController carouselController = CarouselController();
  late RxInt current = 0.obs;
  @override
  void initState() {
    current = widget.initialPage!.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(current.value);
      return Column(
        children: [
          SizedBox(
            height: widget.sliderHeight,
            width: widget.scrolled! ? screenWidth(1.1) : null,
            child: CarouselSlider.builder(
              disableGesture: true,
              carouselController: carouselController,
              options: CarouselOptions(
                  initialPage: current.value,
                  padEnds: widget.padEnds ?? true,
                  // enlargeFactor: 0.5,
                  autoPlay: widget.autoPlay ?? false,
                  enlargeCenterPage: widget.enlargeCenterPage ?? true,
                  viewportFraction: widget.viewportFraction ?? 1.0,
                  enlargeFactor: 0.35,
                  aspectRatio: widget.aspectRatio ?? 3,
                  disableCenter: widget.disableCenter ?? true,
                  onPageChanged: (index, reason) {
                    current.value = index;
                    if (widget.onPageChanged != null) {
                      widget.onPageChanged!(index, reason);
                    }
                  }),
              itemBuilder: widget.itemBuilder ??
                  (BuildContext context, int index, int realIndex) {
                    return SizedBox(child: widget.child);
                  },
              itemCount: widget.itemCount,
            ),
          ),
          if (!widget.scrolled!) ...[
            screenWidth(20).ph,
            Center(child: indicatorBuilder()),
            // screenWidth(20).ph,
          ],
        ],
      );
    });
  }

  AnimatedSmoothIndicator indicatorBuilder() {
    return AnimatedSmoothIndicator(
      effect: WormEffect(
          spacing: 10,
          dotWidth: widget.dotsHeigth ?? 10,
          dotHeight: widget.dotsHeigth ?? 10,
          dotColor: AppColors.fieldBorderColor,
          activeDotColor: AppColors.mainAppColor),
      activeIndex: current.value,
      count: widget.itemCount,
    );
  }
}
