import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ProfessionsProvider extends TechFreneticProvider {
  Future<List<CategoriesModel>> getProfessions() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/professions");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = json.jsonDecode(response.body);
          List<CategoriesModel> professions = [];

          for (var item in jsonResponse) {
            CategoriesModel profession = CategoriesModel.fromMap(item);
            professions.add(profession);
          }
          return professions;
        } else {
          debugPrint('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
