class CateogriesModel {
  bool? status;
  CateogriesDataModel? data;

  CateogriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? CateogriesDataModel.fromJson(json['data'])
        : null;
  }
}

class CateogriesDataModel {
  int? currentPage;
  List<DataModel> data = [];

  CateogriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((cat) {
      data.add(DataModel.fromJson(cat));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel({this.id, this.image, this.name});
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
