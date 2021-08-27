import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/style/theme.dart';
import 'package:shop_app/widgets/appbarMain.dart';

class ProductScreen extends StatelessWidget {
  final int? index;
  ProductScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        bool? isInFavorites =
            cubit.homeModel!.data!.products[index!].infavorites;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 50),
                  CachedNetworkImage(
                    imageUrl: cubit.homeModel!.data!.products[index!].image!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 500,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Color(0xffF5F7FB),
                        image: DecorationImage(
                          image: imageProvider,
                          // fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
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
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 70, 25, 10),
                child: appbarMain(
                  cubit: cubit,
                  context: context,
                  withCart: true,
                  isBackButton: true,
                ),
              ),
              if (cubit.homeModel!.data!.products[index!].discount != 0)
                Positioned(
                  right: MediaQuery.of(context).size.width * .06,
                  bottom: MediaQuery.of(context).size.height / 2.1,
                  child: Container(
                    child: Text(
                      '% ${cubit.homeModel!.data!.products[index!].discount!.toString()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                child: ClipPath(
                  clipper: _MyClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff333333),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 85, 25, 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    cubit.homeModel!.data!.products[index!]
                                        .name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  decoration: BoxDecoration(
                                    color: isInFavorites!
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white24,
                                      width: 1,
                                    ),
                                  ),
                                  child: state is HomeLoadingState
                                      ? Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: accentColor,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            cubit.changeFavorites(cubit
                                                .homeModel!
                                                .data!
                                                .products[index!]
                                                .id!);
                                          },
                                          splashRadius: 24,
                                          iconSize: 24,
                                          icon: Icon(
                                            isInFavorites
                                                ? Icons.bookmark_rounded
                                                : Icons
                                                    .bookmark_outline_rounded,
                                            color: isInFavorites
                                                ? accentColor
                                                : Colors.white,
                                          ),
                                        ),
                                )
                              ],
                            ),
                            SizedBox(height: 3),
                            Text(
                              cubit.homeModel!.data!.products[index!].price!
                                  .toString(),
                              style: TextStyle(
                                fontSize: 25,
                                color: accentColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              cubit.homeModel!.data!.products[index!]
                                  .description!
                                  .toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white54,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (cubit.homeModel!.data!.products[index!].incart!)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen()));
                          else
                            cubit.changeInCart(
                                cubit.homeModel!.data!.products[index!].id!);
                        },
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Color(0xff666666),
                          child: Center(
                            child: Text(
                              cubit.homeModel!.data!.products[index!].incart!
                                  ? 'Go to Cart'
                                  : 'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (!cubit.homeModel!.data!.products[index!].incart!)
                            cubit.changeInCart(
                                cubit.homeModel!.data!.products[index!].id!);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartScreen()));
                        },
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 2,
                          color: accentColor,
                          child: Center(
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //Don't ask me about this mess i don't even know but i found it's the easiest way
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, size.height * .1111111111111111,
        size.width - 50, size.height * .1111111111111111);
    path.lineTo(
        size.width * .1851851851851852, size.height * .1111111111111111);
    path.quadraticBezierTo(
        0, size.height * .11111, 0, size.height * .2555555555555556);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
