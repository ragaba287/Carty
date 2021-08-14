import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/style/theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool cartLoading = false;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is CartChangedSuccessState)
          cartLoading = false;
        else
          cartLoading = true;
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 20,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                      ),
                    ),
                    Text(
                      'My Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    cubit.cartItems.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              cubit.deleteAllCart();
                            },
                            splashRadius: 24,
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              size: 25,
                              color: Colors.black45,
                            ),
                          )
                        : Container(
                            width: 45,
                          ),
                  ],
                ),
              ),
              cubit.cartItems.isNotEmpty
                  ? Expanded(
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount:
                                cubit.cartModel!.cartData!.cartItems.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return cartItem(cubit, index);
                            },
                          ),
                          if (cartLoading)
                            Container(
                              color: Colors.white.withOpacity(.7),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: accentColor,
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'Loading cart...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/home/empty_cart.svg',
                              width: 260),
                          SizedBox(height: 50),
                          Text(
                            'Your Cart is Empty',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Looks like you haven\'t added\nanything to your cart yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.3,
                              letterSpacing: .8,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(height: 50),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: accentColor,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Start Shopping',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
              if (cubit.cartItems.isNotEmpty)
                Container(
                  width: double.infinity,
                  // height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xffE2E6E9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Info',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '\$${cubit.cartModel!.cartData!.subTotal.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  '-\$${cubit.discount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Fee',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Text(
                                  'Free',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: accentColor,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Checkout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget cartItem(HomeCubit cubit, int? index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: cubit.cartItems[index!].productData!.image!,
            imageBuilder: (context, imageProvider) => Container(
              height: 130,
              width: 130,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100]!.withOpacity(.8),
                    blurRadius: 8,
                    spreadRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.grey,
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cubit.cartItems[index].productData!.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      cubit.cartItems[index].productData!.price!.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: accentColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (cubit.cartItems[index].productData!.oldPrice! !=
                        cubit.cartItems[index].productData!.price!)
                      Text(
                        cubit.cartItems[index].productData!.oldPrice!
                            .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    numberChangeIcon(
                      onTap: () {
                        if (cubit.cartItems[index].quantity != 1) {
                          cubit.changeProductQuantity(
                            productId: cubit.cartItems[index].id,
                            quantity: cubit.cartItems[index].quantity! - 1,
                          );
                        } else {
                          cubit.changeInCart(
                              cubit.cartItems[index].productData!.id!);
                        }
                      },
                      icon: Icons.remove,
                    ),
                    Container(
                      // color: Colors.red,
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        cubit.cartItems[index].quantity.toString(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    numberChangeIcon(
                      onTap: () {
                        cubit.changeProductQuantity(
                          productId: cubit.cartItems[index].id,
                          quantity: cubit.cartItems[index].quantity! + 1,
                        );
                      },
                      icon: Icons.add,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell numberChangeIcon({Function? onTap, IconData? icon}) {
    return InkWell(
      onTap: () => onTap!(),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[600]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Colors.grey[600],
          size: 18,
        ),
      ),
    );
  }
}
