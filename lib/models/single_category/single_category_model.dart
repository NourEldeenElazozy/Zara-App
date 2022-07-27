import 'package:salla/models/home/home_model2.dart';

class SingleCategoryModel {
Data data;

SingleCategoryModel({this.data});

SingleCategoryModel.fromJson(Map<String, dynamic> json) {
data = json['data'] != null ? new Data.fromJson(json['data']) : null;
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.data != null) {
    data['data'] = this.data.toJson();
  }
  return data;
}
}

class Data {
  List<Products> data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      data = <Products>[];
      json['products'].forEach((v) {
        data.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['products'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

