import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubitObserver.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/cubit/sign/signCubit.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/sign/signIn.dart';
import 'package:shop_app/sharedpreference/sharedpreference.dart';
import 'package:shop_app/style/theme.dart';
import 'screens/sign/on_boarding.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await Sharedpreference.init();

  Widget widgetHome = OnBoardingScreen();
  bool? onBoarding = await Sharedpreference.getData(key: 'onBoarding');
  token = await Sharedpreference.getData(key: 'token');
  isDarkMode = await Sharedpreference.getData(key: 'isDarkMode') ?? false;
  showHomeBanners =
      await Sharedpreference.getData(key: 'showHomeBanners') ?? false;
  print(token);
  print(isDarkMode);
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
          BlocProvider(create: (BuildContext context) => HomeCubit()),
          if (token != null)
            BlocProvider(
              create: (BuildContext context) => HomeCubit()
                ..getHomeData()
                ..getCateogriesData()
                ..getUserData()
                ..getFavorites(),
            ),
        ],
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
            ));
            return MaterialApp(
              title: 'Shop App',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: widgetHome,
            );
          },
        ));
  }
}
