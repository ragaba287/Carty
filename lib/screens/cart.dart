import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home/homeCubit.dart';
import 'package:shop_app/cubit/home/homeStates.dart';
import 'package:shop_app/model/home/cartModel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is CartChangedSuccessState) {
          HomeCubit.get(context).getCartData();
        }
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
                    IconButton(
                      onPressed: () {
                        //TODO : Delete all cart
                      },
                      splashRadius: 24,
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        size: 25,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: cubit.cartModel!.cartData!.cartItems.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return cartItem(
                      cubit.cartItems[index].productData,
                      cubit.cartItems[index].quantity,
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xffE2E6E9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
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
                          '-\$${cubit.discount.toString()}',
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
            ],
          ),
        );
      },
    );
  }

  Widget cartItem(ProductData? productData, int quantity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: productData!.image!,
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
                  fit: BoxFit.cover,
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
                  productData.name!,
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
                      productData.price!.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 10),
                    if (productData.oldPrice! != productData.price!)
                      Text(
                        productData.oldPrice!.toString(),
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
                        //TODO:increace cart item
                      },
                      icon: Icons.remove,
                    ),
                    Container(
                      // color: Colors.red,
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    numberChangeIcon(
                      onTap: () {
                        //TODO:decreace cart item
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
