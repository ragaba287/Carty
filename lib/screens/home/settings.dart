import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/screens/settings/faq.dart';
import 'package:shop_app/style/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var theme = Theme.of(context);

        return Padding(
          padding: EdgeInsets.fromLTRB(15, 100, 15, 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  //TODO : go to profile page
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(cubit.userModel!.data!.image!),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.userModel!.data!.name!,
                            style: theme.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            cubit.userModel!.data!.email!,
                            style: theme.textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              settingButton(
                context: context,
                onTap: () {},
                switchState: isDarkMode,
                isSwitch: true,
                switchFunction: (value) => cubit.changeThemeMode(value),
              ),
              SizedBox(height: 20),
              settingButton(
                context: context,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FAQScreen(),
                    ),
                  );
                  cubit.getFAQData();
                },
                title: 'FAQ',
                icon: Icons.menu_book_outlined,
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  InkWell settingButton({
    Color iconColor = const Color(0xff5568FE),
    IconData icon = Icons.brightness_2_outlined,
    String title = 'Dark Mode',
    required Function onTap,
    bool isSwitch = false,
    bool switchState = false,
    Function? switchFunction,
    BuildContext? context,
  }) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
            SizedBox(width: 20),
            Text(
              title,
              style: Theme.of(context!).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
            Spacer(),
            isSwitch
                ? CupertinoSwitch(
                    activeColor: accentColor,
                    value: switchState,
                    onChanged: (value) => switchFunction!(value),
                  )
                : Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
