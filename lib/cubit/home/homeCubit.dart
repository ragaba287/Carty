import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/dio/dioHelper.dart';
import 'package:shop_app/model/home/addCartModel.dart';
import 'package:shop_app/model/home/cartModel.dart';
import 'package:shop_app/model/home/cateogriesModel.dart';
import 'package:shop_app/model/home/homeModel.dart';
import 'package:shop_app/model/settings/faqModel.dart';
import 'package:shop_app/model/sign/signUpModel.dart';
import 'package:shop_app/screens/home/cateogries.dart';
import 'package:shop_app/screens/home/favorites.dart';
import 'package:shop_app/screens/home/products.dart';
import 'package:shop_app/screens/home/settings.dart';
import 'package:shop_app/sharedpreference/sharedpreference.dart';

String? token;
bool isDarkMode = false;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void changeThemeMode(bool switchState) {
    isDarkMode = switchState;
    Sharedpreference.saveData(key: 'isDarkMode', value: isDarkMode);
    emit(HomeSuccessState());
  }

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

  SignUpModel? userModel;
  String userName = '';
  void getUserData() {
    DioHelper.getData(url: 'profile', token: token).then((value) {
      userModel = SignUpModel.fromJson(value.data);
      List<String> wordList = userModel!.data!.name!.split(" ");
      if (wordList.isNotEmpty && wordList.length >= 2)
        userName = '${wordList[0]} ${wordList[1][0]}';
    });
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
        } else {
          checkCart();
          getCartData();
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

  List<CartItems> cartItems = [];
  CartModel? cartModel;
  double discount = 0;

  void getCartData() {
    DioHelper.getData(
      url: 'carts',
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      cartItems = cartModel!.cartData!.cartItems;

      discount = 0;
      double totalPrice = 0;
      double totalOldPrice = 0;
      cartModel!.cartData!.cartItems.forEach((item) {
        if (item.productData!.discount != 0) {
          totalOldPrice += item.productData!.oldPrice! * item.quantity!;
          totalPrice += item.productData!.price! * item.quantity!;
        }
      });
      discount = totalOldPrice - totalPrice;
      emit(CartChangedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CartChangedErrorState());
    });
  }

  void deleteAllCart() =>
      cartItems.forEach((product) => changeInCart(product.productData!.id!));

  void changeProductQuantity({
    required int? productId,
    required int? quantity,
  }) {
    emit(CartChangedLoadingState());

    DioHelper.putData(
      url: 'carts/$productId',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      getCartData();
      emit(CartChangedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CartChangedErrorState());
    });
  }

  FaqModel? faqModel;
  void getFAQData() {
    DioHelper.getData(url: 'faqs').then((value) {
      faqModel = FaqModel.fromJson(value.data);
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
