class CategoryModel{
  bool? status;
  DataModel? data;
  CategoryModel.getJson(Map<String,dynamic> json){
    status=json['status'];
    data=DataModel.getJson(json['data']);
  }
}

class DataModel{
  int? currentPage;
  List<DataListModel>? data=[];
  DataModel.getJson(Map<String,dynamic> json){
    currentPage =json['current_page'];
    json['data'].forEach((element){
      data!.add(DataListModel.json(element));
    });
  }
}

class DataListModel{
  int? id;
  String? name;
  String? image;
  DataListModel.json(Map<String, dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}