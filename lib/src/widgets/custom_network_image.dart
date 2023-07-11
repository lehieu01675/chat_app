import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final ColorFilter? colorFilter;
  final double? width;
  final double? height;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.colorFilter,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: colorFilter,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
