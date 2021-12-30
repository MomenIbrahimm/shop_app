class SettingsModel {
  bool? status;
  String? message;
  Data? data;

  SettingsModel({this.status, this.message, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? about;
  String? terms;

  Data({this.about, this.terms});

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }


}
