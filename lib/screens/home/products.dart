import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/model/home/homeModel.dart';
import 'package:shop_app/screens/products/product.dart';
import 'package:shop_app/style/theme.dart';
import 'package:shop_app/widgets/NetImage.dart';
import 'package:shop_app/widgets/appbarMain.dart';
import 'package:shop_app/widgets/bannerSlider.dart';

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
        ThemeData theme = Theme.of(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 70, 25, 0),
                  child: appbarMain(
                      cubit: cubit, context: context, withCart: true)),

              // Big Text and search row
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
                          child: TypeAheadField(
                            hideSuggestionsOnKeyboardHide: true,
                            textFieldConfiguration: TextFieldConfiguration(
                                cursorColor: accentColor,
                                style: TextStyle(
                                  color: theme.brightness == Brightness.dark
                                      ? Color(0xffE9EAEF)
                                      : Colors.grey[900],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 17,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 25),
                                  filled: true,
                                  fillColor: theme.brightness == Brightness.dark
                                      ? Color(0xff252A34)
                                      : Colors.grey[300],
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? Color(0xff252A34)
                                                : Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color:
                                            theme.brightness == Brightness.dark
                                                ? Color(0xff252A34)
                                                : Colors.grey[300]!),
                                  ),
                                )),
                            noItemsFoundBuilder: (_) {
                              return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'No Products Found',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      height: 1.4,
                                    ),
                                  ));
                            },
                            itemBuilder:
                                (BuildContext context, ProductsModel itemData) {
                              return Container(
                                height: 100,
                                width: 100,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.cardColor,
                                ),
                                child: Row(
                                  children: [
                                    netImage(
                                      imageUrl: itemData.image!,
                                      height: 80,
                                      width: 80,
                                      scale: 6,
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemData.name!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.headline5!
                                                .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              height: 1.4,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            '${itemData.price} \$',
                                            style: TextStyle(
                                              color: accentColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onSuggestionSelected: (ProductsModel suggestion) {
                              cubit.homeModel!.data!.products
                                  .forEach((element) {
                                if (element.id == suggestion.id) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductScreen(cubit
                                          .homeModel!.data!.products
                                          .indexOf(element))));
                                }
                              });
                            },
                            suggestionsCallback: (String pattern) async {
                              return cubit.homeModel!.data!.products.where(
                                  (element) => element.name!
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()));
                            },
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
                    ),
                    if (showHomeBanners) bannerCarouselSlider(cubit),
                  ],
                ),
              ),

              // cateogries slider
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
                  netImage(imageUrl: productModel.image!),
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
