class AddToCartModel {
  bool? status;
  String? message;

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
