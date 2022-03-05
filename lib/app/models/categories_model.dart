import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';

class CategoriesModel {
  CategoriesModel({
    required this.id,
    required this.category,
    required this.featured,
    required this.link,
  });

  final String id;
  final String category;
  final String featured;
  final String? link;

  factory CategoriesModel.fromJson(String str) =>
      CategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");
    return CategoriesModel(
      id: json["id"],
      category: json["category"],
      featured: json["featured"],
      link: json["link"] != null ? _baseUrl + json["link"] : "",
    );
  }

  factory CategoriesModel.empty() => CategoriesModel(
        id: "",
        category: "",
        featured: "",
        link: "",
      );

  Map<String, dynamic> toMap() => {
        "target_id": id,
      };

  @override
  String toString() => toJson();
}
