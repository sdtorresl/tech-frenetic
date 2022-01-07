import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CountriesProvider extends TechFreneticProvider {
  Future<List<CategoriesModel>> getCountries() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/paises");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = json.jsonDecode(response.body);
          List<CategoriesModel> events = [];

          for (var item in jsonResponse) {
            CategoriesModel event = CategoriesModel.fromMap(item);
            events.add(event);
          }
          return events;
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
