import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/style/theme.dart';

Widget appbarMain({
  cubit,
  BuildContext? context,
  bool? withCart = false,
}) {
  return Row(
    children: [
      InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {},
        child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              cubit.userModel!.data!.image!,
            )),
      ),
      SizedBox(width: 15),
      Text(
        'Hello ${cubit.userName}!',
        style: TextStyle(
          color: Theme.of(context!).textTheme.headline6!.color,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      Spacer(),
      if (withCart!)
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[300]!.withOpacity(.6),
                width: 1,
              )),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ));
                },
                splashRadius: 24,
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                ),
              ),
              if (cubit.cartIsFull)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
    ],
  );
}
