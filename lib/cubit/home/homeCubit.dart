import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/dio/dioHelper.dart';
import 'package:shop_app/model/home/addCartModel.dart';
import 'package:shop_app/model/home/cartModel.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/model/home/homeModel.dart';
import 'package:shop_app/screens/home/cateogries.dart';
import 'package:shop_app/screens/home/favorites.dart';
import 'package:shop_app/screens/home/products.dart';
import 'package:shop_app/screens/home/settings.dart';

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
  Map<int, bool> inCart = {};
  bool cartIsFull = false;

  void checkCart() {
    if (inCart.containsValue(true))
      cartIsFull = true;
    else
      cartIsFull = false;
  }

  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        inCart.addAll({element.id!: element.incart!});
      });
      checkCart();
      getCartData();

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

  AddToCartModel? addToCart;
  void changeInCart(int productId) {
    inCart[productId] = !inCart[productId]!;
    checkCart();

    emit(AddToCartSuccessState());

    DioHelper.postData(
      url: 'carts',
      data: {
        'product_id': productId,
      },
      token: token,
    ).then(
      (value) {
        addToCart = AddToCartModel.fromJson(value.data);
        if (!addToCart!.status!) {
          inCart[productId] = !inCart[productId]!;
          checkCart();
        }
        emit(AddToCartSuccessState(message: addToCart!.message));
      },
    ).catchError(
      (error) {
        if (!addToCart!.status!) {
          inCart[productId] = !inCart[productId]!;
        }
        emit(AddToCartErrorState());
      },
    );
  }

  List cartItems = [];
  CartModel? cartModel;
  double discount = 0;

  void getCartData() {
    DioHelper.getData(
      url: 'carts',
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      cartItems = cartModel!.cartData!.cartItems;

      cartModel!.cartData!.cartItems.forEach((item) {
        if (item.productData!.discount != 0) {
          discount += item.productData!.oldPrice! - item.productData!.price!;
        }
      });
      emit(CartChangedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CartChangedErrorState());
    });
  }
}
