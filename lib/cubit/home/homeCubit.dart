import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carty/cubit/home/homeStates.dart';
import 'package:carty/dio/dioHelper.dart';
import 'package:carty/model/favoritesModel.dart';
import 'package:carty/model/home/addCartModel.dart';
import 'package:carty/model/home/cartModel.dart';
import 'package:carty/model/home/cateogriesModel.dart';
import 'package:carty/model/home/homeModel.dart';
import 'package:carty/model/settings/faqModel.dart';
import 'package:carty/model/sign/signUpModel.dart';
import 'package:carty/screens/home/cateogries.dart';
import 'package:carty/screens/home/favorites.dart';
import 'package:carty/screens/home/products.dart';
import 'package:carty/screens/home/settings.dart';
import 'package:carty/utils/sharedpreference.dart';

String? token;
bool isDarkMode = false;
bool showHomeBanners = false;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void changeThemeMode(bool switchState) {
    isDarkMode = switchState;
    Sharedpreference.saveData(key: 'isDarkMode', value: isDarkMode);
    emit(HomeSuccessState());
  }

  void showBanners(bool switchState) {
    showHomeBanners = switchState;
    Sharedpreference.saveData(key: 'showHomeBanners', value: showHomeBanners);
    emit(HomeSuccessState());
  }

  bool autoPlayBanners = true;
  void bannerPlay() {
    autoPlayBanners = !autoPlayBanners;
    emit(HomeSuccessState());
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  PageController pageController = PageController(initialPage: 0);
  void changeBottomNav(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
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
      getCateogriesData();

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
    ).then((value) {
      cateogriesModel = CateogriesModel.fromJson(value.data);
    }).catchError((error) {
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
          getHomeData();
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

  void deleteAllCart() {
    emit(CartChangedLoadingState());
    cartItems.forEach((product) => changeInCart(product.productData!.id!));
  }

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
    }).catchError((error) {
      print(error.toString());
      emit(CartChangedErrorState());
    });
  }

  FaqModel? faqModel;
  void getFAQData() {
    if (faqModel == null) {
      emit(HomeLoadingState());
      DioHelper.getData(url: 'faqs').then((value) {
        faqModel = FaqModel.fromJson(value.data);
        emit(HomeSuccessState());
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      emit(HomeSuccessState());
    }
  }

  void logout() {
    DioHelper.postData(url: 'logout', data: {}, token: token)
        .then((value) async {
      print('logedout');
      await Sharedpreference.removeData(key: 'token');
    }).catchError((error) {
      print(error.toString());
    });
  }

  void changeFavorites(int productId) {
    emit(HomeLoadingState());

    DioHelper.postData(
      url: 'favorites',
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      print(value.data);
      getHomeData();
      getFavorites();
    }).catchError((error) {
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
