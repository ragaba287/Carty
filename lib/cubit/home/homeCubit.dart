import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/dio/dioHelper.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/model/home/homeModel.dart';
import 'package:shop_app/screens/cateogries.dart';
import 'package:shop_app/screens/favorites.dart';
import 'package:shop_app/screens/products.dart';
import 'package:shop_app/screens/settings.dart';

String? token;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  bool autoPlayBanners = true;
  void bannerPlay() {
    autoPlayBanners = !autoPlayBanners;
    emit(HomeSuccessState());
  }

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeChangeNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
      print(error.toString());
    });
  }

  CateogriesModel? cateogriesModel;
  void getCateogriesData() {
    DioHelper.getData(
      url: 'categories',
      token: token,
    ).then((value) {
      cateogriesModel = CateogriesModel.fromJson(value.data);
      emit(CateogriesSuccessState());
    }).catchError((error) {
      emit(CateogriesErrorState());
      print(error.toString());
    });
  }
}
