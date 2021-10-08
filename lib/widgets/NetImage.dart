import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carty/style/theme.dart';

Widget netImage({
  required String imageUrl,
  double height = 160,
  double width = double.infinity,
  EdgeInsets? margin,
  BoxFit? fit,
  double scale = 1,
}) {
  return Container(
    height: height,
    width: width,
    margin: margin,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            scale: scale,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: LinearProgressIndicator(
          value: downloadProgress.progress,
          color: accentColor,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.red,
      ),
    ),
  );
}
