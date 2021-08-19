class FavoritesModel {
  bool? status;
  String? message;
  DataFavoritesModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? DataFavoritesModel.fromJson(json['data']) : null;
  }
}

class DataFavoritesModel {
  List<DataFavoritesListModel> dataFavoritesListModel = [];
  int? total;

  DataFavoritesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataFavoritesListModel.add(DataFavoritesListModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class DataFavoritesListModel {
  int? id;
  FavoritesProductModel? product;

  DataFavoritesListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? FavoritesProductModel.fromJson(json['product'])
        : null;
  }
}

class FavoritesProductModel {
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoritesProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
