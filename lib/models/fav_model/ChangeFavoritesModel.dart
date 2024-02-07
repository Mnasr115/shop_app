import 'Data.dart';

class ChangeFavoritesModel {
  ChangeFavoritesModel({
      this.status, 
      this.message, 
    });

  ChangeFavoritesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];

  }
  bool? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}