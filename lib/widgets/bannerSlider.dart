import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carty/cubit/home/homeCubit.dart';

Stack bannerCarouselSlider(HomeCubit cubit) {
  return Stack(
    children: [
      CarouselSlider(
        items: cubit.homeModel!.data!.banners
            .map(
              (banner) => CachedNetworkImage(
                imageUrl: banner.image!,
                imageBuilder: (context, imageProvider) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Color(0xffF5F7FB),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(.0),
                        BlendMode.srcATop,
                      ),
                      // fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.grey,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          initialPage: 0,
          scrollPhysics: BouncingScrollPhysics(),
          viewportFraction: 1,
          height: 280,
          autoPlay: cubit.autoPlayBanners,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          reverse: false,
        ),
      ),
      Positioned(
        right: 30,
        bottom: 50,
        child: Container(
          width: 35,
          height: 35,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.grey[300]!.withOpacity(.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            splashRadius: 30,
            iconSize: 25,
            onPressed: () => cubit.bannerPlay(),
            icon: cubit.autoPlayBanners
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
          ),
        ),
      ),
    ],
  );
}
