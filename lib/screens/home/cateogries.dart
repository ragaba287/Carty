import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/style/theme.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var cateogriesModel = cubit.cateogriesModel!.data!.data;

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 70, 25, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(cubit.userModel!.data!.image!),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Hello ${cubit.userName}!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Text(
                  'All',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Cateogries',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cateogriesModel.length,
                  physics: BouncingScrollPhysics(),
                  // padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    //either cateogryItem1 or cateogryItem2
                    return cateogryItem2(cateogriesModel[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget cateogryItem2(DataModel cateogriesModel) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: cateogriesModel.image!,
            imageBuilder: (context, imageProvider) => Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100]!.withOpacity(.8),
                    blurRadius: 8,
                    spreadRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(.2),
                    BlendMode.srcOver,
                  ),
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
          SizedBox(width: 15),
          Text(
            cateogriesModel.name!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }

  Widget cateogryItem(DataModel cateogriesModel) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: cateogriesModel.image!,
          imageBuilder: (context, imageProvider) => Container(
            height: 180,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100]!.withOpacity(.8),
                  blurRadius: 8,
                  spreadRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(.5),
                  BlendMode.srcOver,
                ),
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
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
        Positioned(
          bottom: 20,
          child: Text(
            cateogriesModel.name!,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
