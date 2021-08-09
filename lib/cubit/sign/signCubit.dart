import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio/dioHelper.dart';
import 'package:shop_app/model/sign/loginModel.dart';
import 'package:shop_app/model/sign/signUpModel.dart';
import 'package:shop_app/cubit/sign/signStates.dart';

class ShopSignCubit extends Cubit<ShopStates> {
  ShopSignCubit() : super(ShopLoginInitState());

  static ShopSignCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      emit(ShopLoginSuccessState(loginModel: LoginModel.fromJson(value.data)));
    }).catchError((error) {
      print('error ${error.toString()}');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      emit(ShopRegisterSuccessState(
          signUpModel: SignUpModel.fromJson(value.data)));
    }).catchError((error) {
      print('error ${error.toString()}');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isobscure = true;
  IconData suffixEyeIcon = Icons.remove_red_eye_outlined;

  void showPassword() {
    isobscure = !isobscure;
    suffixEyeIcon = isobscure
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(ShopPasswordVisiablityState());
  }
}
