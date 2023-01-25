import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CountriesProvider extends TechFreneticProvider {
  Future<List<CategoriesModel>> getCountries() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/countrys");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<CategoriesModel> countries =
            jsonResponse.map((e) => CategoriesModel.fromMap(e)).toList();
        return countries;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
