import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/sign/signCubit.dart';
import 'package:shop_app/cubit/sign/signStates.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/sign/signUp.dart';
import 'package:shop_app/sharedpreference/sharedpreference.dart';
import 'package:shop_app/widgets/buttonMain.dart';
import 'package:shop_app/widgets/textFieldGrey.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var formKey = GlobalKey<FormState>();
    var usernameTextEdit = TextEditingController();
    var passwordTextEdit = TextEditingController();
    return BlocConsumer<ShopSignCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel!.status!) {
            print(state.loginModel!.message);
            print(state.loginModel!.data!.token);

            Sharedpreference.saveData(
                key: 'token', value: state.loginModel!.data!.token);

            Fluttertoast.showToast(
                msg: state.loginModel!.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: theme.accentColor,
                textColor: Colors.white,
                fontSize: 16.0);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          } else {
            print(state.loginModel!.message);
            Fluttertoast.showToast(
                msg: state.loginModel!.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopSignCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: theme.textTheme.headline5,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Please sign in to your account',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .5,
                          ),
                        ),
                        SizedBox(height: 80),
                        TextfieldGray(
                          hintText: 'Email Address',
                          textEditingController: usernameTextEdit,
                          suffixPressed: () {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be empty';
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        TextfieldGray(
                          hintText: 'Password',
                          textEditingController: passwordTextEdit,
                          isobscure: cubit.isobscure,
                          showSuffix: true,
                          suffixIcon: cubit.suffixEyeIcon,
                          suffixPressed: () => cubit.showPassword(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        state is ShopLoginLoadingState
                            ? Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                  color: theme.accentColor,
                                ),
                              )
                            : MainButton(
                                title: 'Sign In',
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: usernameTextEdit.text,
                                      password: passwordTextEdit.text,
                                      // email: 'abullah@gmail.com',
                                      // password: '123456',
                                    );
                                  } else {
                                    print('Form is invalid');
                                  }
                                },
                              ),
                        SizedBox(height: 15),
                        MainButton(
                          title: 'Sign In with Google',
                          color: Colors.white,
                          onPressed: () {},
                          svgIcon: 'assets/google-icon.svg',
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an Account?',
                                  style: TextStyle(
                                    color: theme.textTheme.headline5?.color,
                                    fontSize: 16,
                                    letterSpacing: .5,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Sign Up',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
