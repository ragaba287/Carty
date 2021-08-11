import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/style/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var theme = Theme.of(context);

        return Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.apps_rounded),
          //   ),
          //   actions: [
          //     IconButton(
          //         onPressed: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => SearchScreen()),
          //           );
          //         },
          //         icon: Icon(Icons.search)),
          //   ],
          // ),
          body: state is HomeSuccessState ||
                  state is HomeChangeNavState ||
                  state is AddToCartSuccessState ||
                  state is CartChangedSuccessState
              ? cubit.bottomScreens[cubit.currentIndex]
              : Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
              elevation: 10,
              currentIndex: cubit.currentIndex,
              selectedItemColor: theme.accentColor,
              unselectedItemColor: Colors.grey[500],
              onTap: (index) => cubit.changeBottomNav(index),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Cateogries'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
