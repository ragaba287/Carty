import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/style/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var theme = Theme.of(context);

        return Scaffold(
          body: state is HomeSuccessState ||
                  state is HomeChangeNavState ||
                  state is AddToCartSuccessState ||
                  state is CartChangedSuccessState
              ? PageView(
                  controller: _pageController,
                  children: cubit.bottomScreens,
                  onPageChanged: (index) => cubit.changeBottomNav(index),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: BottomNavyBar(
              itemCornerRadius: 12,
              curve: Curves.easeInCubic,
              onItemSelected: (index) {
                cubit.changeBottomNav(index);
                _pageController.jumpToPage(index);
              },
              selectedIndex: cubit.currentIndex,
              backgroundColor: Colors.transparent,
              showElevation: false,
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.home_outlined),
                  title: Text('Home'),
                  activeColor: accentColor,
                  inactiveColor: Colors.grey[500],
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.apps_rounded),
                  title: Text('Categories'),
                  activeColor: accentColor,
                  inactiveColor: Colors.grey[500],
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.bookmark_outline),
                  title: Text('Bookmark'),
                  activeColor: accentColor,
                  inactiveColor: Colors.grey[500],
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                  activeColor: accentColor,
                  inactiveColor: Colors.grey[500],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
