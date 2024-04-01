import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage(
      {super.key, required this.imageUrl, this.height, this.width, this.scale});
  final String imageUrl;
  final double? height, width, scale;
  @override
  State<CustomNetworkImage> createState() => _CustomProductImageState();
}

class _CustomProductImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Transform.scale(
          scale: widget.height.isNull && widget.width.isNull
              ? widget.scale ?? 0.8
              : 1,
          child: CachedNetworkImage(
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
