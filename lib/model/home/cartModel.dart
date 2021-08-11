class CartModel {
  bool? status;
  String? message;
  CartData? cartData;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cartData = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<CartItems> cartItems = [];
  int? subTotal;
  int? total;

  CartData.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((item) {
      cartItems.add(CartItems.fromJson(item));
    });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  int? id;
  int? quantity;
  ProductData? productData;
  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productData =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
  }
}

class ProductData {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
