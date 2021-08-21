import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/favoritesModel.dart';
import 'package:shop_app/screens/products/product.dart';
import 'package:shop_app/style/theme.dart';
import 'package:shop_app/widgets/appbarMain.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: appbarMain(
                        cubit: cubit, context: context, withCart: true),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit
                          .favoritesModel!.data!.dataFavoritesListModel.length,
                      itemBuilder: (context, index) {
                        return productItem(cubit.favoritesModel,
                            Theme.of(context), cubit, context, index);
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget productItem(FavoritesModel? favoritesModel, ThemeData theme,
      HomeCubit cubit, context, int index) {
    return InkWell(
      onTap: () {
        cubit.homeModel!.data!.products.forEach((element) {
          if (element.id ==
              favoritesModel!.data!.dataFavoritesListModel[index].product!.id) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductScreen(
                    cubit.homeModel!.data!.products.indexOf(element))));
          }
        });
      },
      child: Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CachedNetworkImage(
                  imageUrl: favoritesModel!
                      .data!.dataFavoritesListModel[index].product!.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 140,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.scaleDown,
                        scale: 6,
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
                if (favoritesModel.data!.dataFavoritesListModel[index].product!
                        .discount! !=
                    0)
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
                          '${favoritesModel.data!.dataFavoritesListModel[index].product!.discount!} %',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${favoritesModel.data!.dataFavoritesListModel[index].product!.name!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headline5!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$ ${favoritesModel.data!.dataFavoritesListModel[index].product!.price!.toString()}',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.changeFavorites(favoritesModel.data!
                              .dataFavoritesListModel[index].product!.id!);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: accentColor,
                            border: Border.all(
                              color: accentColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.bookmark_outlined,
                            color: Colors.white,
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
}
