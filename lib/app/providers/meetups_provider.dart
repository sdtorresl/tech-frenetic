import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/meetups_model.dart';
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class MeetupsProvider extends TechFreneticProvider {
  Future<List<MeetupsModel>> getMeetups() async {
    List<MeetupsModel> meetups = [];
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/meetups?page=0");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        MeetupsWallModel wall = MeetupsWallModel.fromMap(jsonResponse);
        meetups = wall.articles;
        debugPrint(meetups.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return meetups;
  }

  Future<MeetupsWallModel> getMeetupsWall() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/meetups?page=0");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        MeetupsWallModel wall = MeetupsWallModel.fromMap(jsonResponse);

        return wall;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    return MeetupsWallModel.empty();
  }
}
