class FavouriteModel{
  late bool status;
  String? message;

  FavouriteModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}