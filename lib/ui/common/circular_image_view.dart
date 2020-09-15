import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/image_paths.dart';

class CircularImageView extends StatelessWidget {
  const CircularImageView(
      {@required this.url, this.height = 40, this.width = 40, @required this.callBack});

  final double width;
  final double height;
  final String url;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(url)))),
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              direction: ShimmerDirection.rtl,
              period: const Duration(milliseconds: 1000),
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )),
          errorWidget: (context, url, error) => Image.asset(icUploadImage)),
    );
  }
}
