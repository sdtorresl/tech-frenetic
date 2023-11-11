import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/mappers/advertisement_mapper.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import '../models/advertisement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdvertisementProvider extends TechFreneticProvider {
  Future<List<AdvertisementModel>> getAdvertisements() async {
    List<AdvertisementModel> advertisements = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/advertisement");
      var response = await http.get(_url);

      debugPrint("Getting advertisements...");
      debugPrint(_url.toString());

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        advertisements =
            jsonResponse.map((a) => AdvertisementMapper.fromMap(a)).toList();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return advertisements;
  }
}
