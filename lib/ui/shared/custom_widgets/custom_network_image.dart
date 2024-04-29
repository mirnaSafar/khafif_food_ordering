import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.scale,
      this.fit});
  final String imageUrl;
  final BoxFit? fit;
  final double? height, width, scale;
  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Transform.scale(
          scale: widget.height.isNull && widget.width.isNull
              ? widget.scale ?? 0.8
              : 1,
          child: CachedNetworkImage(
            fit: widget.fit,
            fadeInDuration: const Duration(milliseconds: 500),
            placeholder: (context, url) => Transform.scale(
              scale: 0.5,
              child: SvgPicture.asset(
                'assets/images/info.svg',
                // width: screenWidth(10),
                // height: screenWidth(50),
                color: AppColors.mainGreyColor,
              ),
            ),
            // fit: BoxFit.cover,
            height: widget.height,
            width: widget.width,
            imageUrl: widget.imageUrl,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ));
  }
}
