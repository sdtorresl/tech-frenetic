import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CategoriesProvider extends TechFreneticProvider {
  Future<List<CategoriesModel>> getCategories() async {
    List<CategoriesModel> englishCategories = [];
    List<CategoriesModel> spanishCategories = [];
    List<int> indexList = [];
    List<int> evenList = [];
    List<int> oddList = [];

    int index = 0;
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/v1/categories");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List jsonResponse = json.jsonDecode(response.body);
        while (index < jsonResponse.length) {
          int element = index++;
          indexList.add(element);
        }
        for (var item in indexList) {
          if (item.isEven) {
            evenList.add(item);
          }
          if (item.isOdd) {
            oddList.add(item);
          }
        }
        while (evenList.length > englishCategories.length) {
          for (var item in evenList) {
            englishCategories.add(
              CategoriesModel.fromMap(jsonResponse[item]),
            );
          }
        }
        while (oddList.length > spanishCategories.length) {
          for (var item in oddList) {
            spanishCategories.add(
              CategoriesModel.fromMap(jsonResponse[item]),
            );
          }
        }
        // debugPrint(englishCategories.toString());
        // debugPrint(spanishCategories.toString());
        // debugPrint(indexList.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    if (locale == 'en') {
      return englishCategories;
    } else if (locale == 'es') {
      return spanishCategories;
    } else {
      return [];
    }
  }

  Future<List<CategoriesModel>> getInterests() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/interest");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<CategoriesModel> interests = [];

        for (var item in jsonResponse) {
          CategoriesModel interest = CategoriesModel.fromMap(item);
          interests.add(interest);
        }
        return interests;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
