class Autogenerated {
  late bool status;
  late Data data;

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ?  Data.fromJson(json['data']) : null)!;
  }
}

class Data{
  List<DataProduct> dataProduct=[];
  late int currentPage;

  Data.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      dataProduct.add(DataProduct.fromJson(element));

    });
  }

}
class DataProduct {
  late int id;
  late Product product;

  DataProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ?  Product.fromJson(json['product']) : null)!;
  }

}

class Product {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
