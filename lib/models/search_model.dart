class SearchModel {
   bool? status;
   Data_Product? data;

  SearchModel.json(Map<String, dynamic> json) {
    status = json['status'];
    data = Data_Product.json(json["data"]);
  }
}

class Data_Product {
   int? current_page;
   List<DataList>? data = [];
   String? firstPageUrl;
   int? from;
   int? lastPage;
   String? lastPageUrl;
   String? path;
   int? per_page;
   int? to;
   dynamic total;

  Data_Product.json(Map<String, dynamic> json) {
    current_page = json["current_page"];

    json['data'].forEach((element) {
      data!.add(DataList.json(element));
    });
    firstPageUrl = json['first_page_url'];

    from = json['from'];

    lastPage = json['last_page'];

    path = json['path'];

    to = json['to'];
    lastPageUrl = json['last_page_url'];
    total = json['total'];
    per_page = json['per_page'];
  }
}

class DataList {
   int? id;
   dynamic price;
   String? image;
   String? name;
   String? description;
   List? images = [];
   dynamic favorite;
   dynamic in_cart;

  DataList.json(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    print(description);
    json['images'].forEach((element) {
      images!.add(element);
    });
    favorite = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
