import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/model/home/homeModel.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/products/product.dart';
import 'package:shop_app/screens/search.dart';
import 'package:shop_app/style/theme.dart';
import 'package:shop_app/widgets/appbarMain.dart';
import 'package:shop_app/widgets/textFieldGrey.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddToCartSuccessState && state.message != null)
          Fluttertoast.showToast(
            msg: state.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: accentColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var cateogriesModel = cubit.cateogriesModel!.data!.data;
        TextEditingController searchTextEditingController =
            TextEditingController();
        ThemeData theme = Theme.of(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //user image , name and bell
              Padding(
                padding: EdgeInsets.fromLTRB(25, 70, 25, 0),
                child:
                    appbarMain(cubit: cubit, context: context, withCart: true),
              ),

              //Big Text and search row
              Padding(
                padding: EdgeInsets.fromLTRB(25, 40, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Our',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'New Deals',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: TextfieldGray(
                            textEditingController: searchTextEditingController,
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: accentColor,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.all(7),
                            constraints: BoxConstraints(
                              minHeight: 70,
                              minWidth: 70,
                            ),
                            onPressed: () {},
                            splashRadius: 30,
                            color: Colors.white,
                            icon: Icon(Icons.filter_list_rounded, size: 25),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (showHomeBanners)
                Stack(
                  children: [
                    CarouselSlider(
                      items: cubit.homeModel!.data!.banners
                          .map(
                            (banner) => CachedNetworkImage(
                              imageUrl: banner.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 40),
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
                ),

              //cateogries slider
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 20, 10),
                child: Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => cubit.changeBottomNav(1),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cateogriesModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<DataModel> modifiedCateogries = [];

                    modifiedCateogries
                        .add(DataModel(id: 1, name: 'All', image: ''));
                    modifiedCateogries.addAll(cateogriesModel);
                    return Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                          decoration: BoxDecoration(
                            color: modifiedCateogries[index].name == 'All'
                                ? accentColor
                                : theme.brightness == Brightness.dark
                                    ? theme.cardColor
                                    : Color(0xffF5F7FB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            modifiedCateogries[index].name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: modifiedCateogries[index].name == 'All'
                                  ? Colors.white
                                  : theme.brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'All Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                childAspectRatio: 1 / 1.43,
                // childAspectRatio: 1 / 1.8,
                children: List.generate(
                  cubit.homeModel!.data!.products.length,
                  (index) => productItem(cubit.homeModel!.data!.products[index],
                      theme, cubit, context, index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget productItem(ProductsModel productModel, ThemeData theme,
          HomeCubit cubit, context, int index) =>
      InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductScreen(index)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 160,
                    child: CachedNetworkImage(
                      imageUrl: productModel.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
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
                  ),
                  if (productModel.discount! != 0)
                    Positioned(
                      bottom: 15,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // height: 20,
                        child: Center(
                          child: Text(
                            '${productModel.discount!} %',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  children: [
                    Text(
                      '${productModel.name!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headline5!.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$ ${productModel.price!.toString()}',
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        InkWell(
                          onTap: () => cubit.changeInCart(productModel.id!),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: cubit.inCart[productModel.id]!
                                  ? accentColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: cubit.inCart[productModel.id]!
                                    ? accentColor
                                    : theme.textTheme.headline5!.color!,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              cubit.inCart[productModel.id]!
                                  ? Icons.shopping_cart_outlined
                                  : Icons.add,
                              color: cubit.inCart[productModel.id]!
                                  ? Colors.white
                                  : theme.textTheme.headline5!.color!,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
