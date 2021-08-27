import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/style/theme.dart';
import 'package:shop_app/widgets/NetImage.dart';
import 'package:shop_app/widgets/appbarMain.dart';

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
                  child: appbarMain(
                      cubit: cubit, context: context, withCart: false),
                ),
                Text(
                  'All',
                  style: TextStyle(fontSize: 28),
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
                  itemBuilder: (context, index) {
                    return cateogryItem(cateogriesModel[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget cateogryItem(DataModel cateogriesModel) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Row(
        children: [
          netImage(
            imageUrl: cateogriesModel.image!,
            height: 80,
            width: 80,
            margin: EdgeInsets.fromLTRB(0, 18, 20, 18),
          ),
          Text(
            cateogriesModel.name!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
