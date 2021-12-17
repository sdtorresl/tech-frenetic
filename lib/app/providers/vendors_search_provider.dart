import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class VendorsSearchProvider extends TechFreneticProvider {
  Future<WallModel> getVendorWall() async {
    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/partners?_format=json&content[]=vendor");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        WallModel wall = WallModel.fromMap(jsonResponse);
        return wall;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return WallModel.empty();
  }
}
