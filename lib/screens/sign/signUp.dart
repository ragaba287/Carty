import 'package:carty/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carty/cubit/home/homeCubit.dart';
import 'package:carty/cubit/sign/signCubit.dart';
import 'package:carty/cubit/sign/signStates.dart';
import 'package:carty/screens/home/home.dart';
import 'package:carty/utils/sharedpreference.dart';
import 'package:carty/widgets/buttonMain.dart';
import 'package:carty/widgets/textFieldGrey.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var formKey = GlobalKey<FormState>();
    var fullNameTextEdit = TextEditingController();
    var emailTextEdit = TextEditingController();
    var phoneTextEdit = TextEditingController();
    var passwordTextEdit = TextEditingController();

    return BlocConsumer<ShopSignCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.signUpModel!.status!) {
            print(state.signUpModel!.message);
            print(state.signUpModel!.data!.token);

            Sharedpreference.saveData(
                    key: 'token', value: state.signUpModel!.data!.token)
                .then((value) {
              token = state.signUpModel!.data!.token;
              BlocProvider.of<HomeCubit>(context)
                ..getHomeData()
                ..getCateogriesData()
                ..getUserData()
                ..getFavorites();
              navPushRemove(context, HomeScreen());
            });

            Fluttertoast.showToast(
                msg: state.signUpModel!.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: theme.accentColor,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            print(state.signUpModel!.message);
            Fluttertoast.showToast(
                msg: state.signUpModel!.message!,
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
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Create new account',
                          style: theme.textTheme.headline5),
                      SizedBox(height: 15),
                      Text('Please fill in the form to continue',
                          style: theme.textTheme.subtitle1),
                      SizedBox(height: 80),
                      TextfieldGray(
                        hintText: 'Full Name',
                        textEditingController: fullNameTextEdit,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your Name' : null,
                      ),
                      SizedBox(height: 15),
                      TextfieldGray(
                        hintText: 'Email Address',
                        textEditingController: emailTextEdit,
                        validator: (String value) {
                          if (value.isEmpty) return 'please enter your email';
                          if (!value.contains("@"))
                            return 'Email is not correct';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextfieldGray(
                        hintText: 'Phone Number',
                        textEditingController: phoneTextEdit,
                        textInputType: TextInputType.phone,
                        validator: (value) =>
                            value.isEmpty ? 'please enter your Phone' : null,
                      ),
                      SizedBox(height: 15),
                      TextfieldGray(
                        hintText: 'Password',
                        textEditingController: passwordTextEdit,
                        isobscure: cubit.isobscure,
                        suffixIcon: cubit.suffixEyeIcon,
                        suffixPressed: () => cubit.showPassword(),
                        validator: (value) =>
                            value.isEmpty ? 'please enter your Password' : null,
                      ),
                      SizedBox(height: 80),
                      state is ShopRegisterLoadingState
                          ? Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: theme.accentColor,
                              ),
                            )
                          : MainButton(
                              title: 'Sign Up',
                              color: theme.accentColor,
                              onPressed: () {
                                if (formKey.currentState!.validate())
                                  cubit.userRegister(
                                    name: fullNameTextEdit.text,
                                    phone: phoneTextEdit.text,
                                    email: emailTextEdit.text,
                                    password: passwordTextEdit.text,
                                  );
                              },
                            ),
                      SizedBox(height: 25),
                      TextButton(
                        onPressed: () => navPop(context),
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
                                text: 'Have an Account?',
                                style: TextStyle(
                                  color: theme.textTheme.headline5?.color,
                                  fontSize: 16,
                                  letterSpacing: .5,
                                ),
                              ),
                              TextSpan(
                                text: ' Sign In',
                                style: TextStyle(
                                  color: theme.accentColor,
                                  fontSize: 16,
                                  letterSpacing: .5,
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
        );
      },
    );
  }
}
