class FaqModel {
  bool? status;
  String? message;
  FaqDataModel? data;

  FaqModel();
  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FaqDataModel.fromJson(json['data']) : null;
  }
}

class FaqDataModel {
  List<QuestionData> data = [];

  FaqDataModel.fromJson(Map<String, dynamic> json) {
    json['data']
        .forEach((question) => data.add(QuestionData.fromJson(question)));
  }
}

class QuestionData {
  int? id;
  String? question;
  String? answer;

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
