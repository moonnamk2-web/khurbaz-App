import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CacheNetworkImageWidget extends StatefulWidget {
  const CacheNetworkImageWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
  });

  final String url;
  final double? height;
  final double? width;

  @override
  State<CacheNetworkImageWidget> createState() =>
      _CacheNetworkImageWidgetState();
}

class _CacheNetworkImageWidgetState extends State<CacheNetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
          height: widget.height,
          width: widget.width,
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        height: widget.height,
        width: widget.width,
        decoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: widget.height,
        width: widget.width,
        child: const Icon(Icons.error),
      ),
    );
  }
}
