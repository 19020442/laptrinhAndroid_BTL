
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,

    this.color,
    this.blendMode,
    this.backgroundColor,
  }) : super(key: key);

  final String? url;

  final BorderRadius? borderRadius;

  final BoxFit fit;

  final double? width;

  final double? height;


  final Color? color;

  final BlendMode? blendMode;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[350],
        child: CachedNetworkImage(
          key: key,
          imageUrl: url!,
          colorBlendMode: blendMode,
          color: color,
          placeholder: (_, url) => const LoadingWidget(),
       
          fit: fit,
        ),
      ),
    );
  }
}
