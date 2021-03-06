import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/cubitObserver.dart';
import '/cubit/home/homeCubit.dart';
import '/cubit/home/homeStates.dart';
import '/cubit/sign/signCubit.dart';
import '/screens/home/home.dart';
import '/screens/sign/signIn.dart';
import '/utils/sharedpreference.dart';
import '/style/theme.dart';
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
                ..getCateogriesData()
                ..getHomeData()
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
              debugShowCheckedModeBanner: false,
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
