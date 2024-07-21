import 'dart:convert';

import 'package:techfrenetic/app/models/categories_model.dart';

class BrandsCategoriesMapper {
  static CategoriesModel fromMap(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['tid'],
      category: json['name'],
      featured: '',
      link: '',
    );
  }

  CategoriesModel fromJson(String str) => fromMap(json.decode(str));
}
