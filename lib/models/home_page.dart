import 'package:flutter/material.dart';

class HomePageModels{
  bool? status;
  DataModel? data;
  HomePageModels.fromjson({
    required Map<String,dynamic> json,
}){
    status=json["status"];
    data=DataModel.fromjson(json: json["data"]);


  }
}
class DataModel{
  List<Banner> banners=[];
  List<Product> product=[];

  DataModel.fromjson({
    required Map<String,dynamic> json,
}){
    json['banners'].forEach((element) {
      banners.add(Banner(json: element));
    });
    json['products'].forEach((element) {
    product.add( Product(json: element)) ;
    });


  }

}
class Banner{
  int? id;
  String? image;
  Banner({
    required Map<String,dynamic> json,
}){
    id=json['id'];
    image=json['image'];
  }
}
class Product{
 int? id;
 dynamic price;
 dynamic oldPrice;
 dynamic discount;
 String? image;
 String? name;
 bool? inFavorites;
 bool? inCards;

 Product({
   required Map<String,dynamic> json,
 }){
   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];
   inFavorites=json['in_favorites'];
   inCards=json['in_cart'];
 }

}