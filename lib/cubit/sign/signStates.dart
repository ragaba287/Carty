import 'package:shop_app/model/sign/loginModel.dart';
import 'package:shop_app/model/sign/signUpModel.dart';

abstract class ShopStates {}

// LoginStates
class ShopLoginInitState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessState extends ShopStates {
  final LoginModel? loginModel;
  ShopLoginSuccessState({required this.loginModel});
}

class ShopLoginErrorState extends ShopStates {
  final String error;
  ShopLoginErrorState(this.error);
}

// RegisterStates
class ShopRegisterInitState extends ShopStates {}

class ShopRegisterLoadingState extends ShopStates {}

class ShopRegisterSuccessState extends ShopStates {
  final SignUpModel? signUpModel;
  ShopRegisterSuccessState({required this.signUpModel});
}

class ShopRegisterErrorState extends ShopStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopPasswordVisiablityState extends ShopStates {}
