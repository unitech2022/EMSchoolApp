import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utlis/api_constatns.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String image;
  final double height,width;
  final BoxFit? fit;
  final Widget? errorWidget;
  const ImageNetworkWidget({super.key, required this.image, required this.height, required this.width, this.fit,this.errorWidget});



  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiConstants.imageUrl(image),
      height:width,
      width: width,
      placeholder: (context, url) =>SizedBox(
          height:width,
          width: width,
          child: const Center(child: CircularProgressIndicator())) ,
      errorWidget: (context, url, error) =>errorWidget?? const Icon(Icons.error),
      fit:fit?? BoxFit.cover,
    );
  }
}