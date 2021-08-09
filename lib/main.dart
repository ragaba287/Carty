import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/sign/signCubit.dart';
import 'package:shop_app/screens/home.dart';
import 'package:shop_app/screens/sign/login.dart';
import 'package:shop_app/sharedpreference/sharedpreference.dart';
import 'package:shop_app/style/theme.dart';
import '../screens/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sharedpreference.init();

  Widget widgetHome = OnBoardingScreen();
  bool? onBoarding = await Sharedpreference.getData(key: 'onBoarding');
  token = await Sharedpreference.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widgetHome = HomeScreen();
    else
      widgetHome = LoginScreen();
  } else {
    widgetHome = OnBoardingScreen();
  }

  runApp(MyApp(widgetHome: widgetHome));
}

class MyApp extends StatelessWidget {
  final Widget widgetHome;
  MyApp({required this.widgetHome});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopSignCubit()),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getHomeData()
            ..getCateogriesData(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: widgetHome,
      ),
    );
  }
}
