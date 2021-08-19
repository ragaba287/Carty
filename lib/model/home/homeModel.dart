class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  String? ad;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners']
        .forEach((banner) => banners.add(BannerModel.fromJson(banner)));

    json['products']
        .forEach((product) => products.add(ProductsModel.fromJson(product)));

    ad = json['ad'];
  }
}

class BannerModel {
  int? id;
  String? image;
  String? product;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    product = json['product'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? infavorites;
  bool? incart;
  List<String> images = [];

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
    images = json['images'].cast<String>();
  }
}
