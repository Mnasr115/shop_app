

class ChangeFavoritesModel {
  bool? status;
  String? message;

  ChangeFavoritesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }


}
