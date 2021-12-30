class CategoryModel{
  bool? status;
  DataModel? data;

  CategoryModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel{
  int? currentPage;
  List<CategoryDataModel> dataModel = [];

  DataModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      dataModel.add(CategoryDataModel.fromJson(element));
    });
  }
}
class CategoryDataModel{
  int? id;
  String? name;
  String? image;

  CategoryDataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}
