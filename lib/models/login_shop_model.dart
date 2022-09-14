import 'package:mealapp/modules/login/log%20in.dart';

class LogInModel {
  
  bool? status;
  String? message;
  UserData? data;

  LogInModel.jsonData(Map <String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data= json['data']==null ? null :UserData.jsonData(json['data']);


  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogInModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.jsonData(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }


}


