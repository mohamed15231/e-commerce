class FavoriteModel{
  late bool status;
  late String message;
  FavoriteModel.json({
    required Map<String,dynamic> json,
}){
    status=json["status"];
    message=json["message"];
  }
}