import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

  Future<bool?> createMeetup(
      String url, DateTime date, String location, String title) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/node?_format=json");
      DateFormat('dd/MMM/yyyy').format(date);
      Map<String, dynamic> body = {
        "field_event_url": [
          {"uri": url}
        ],
        "field_when": [
          {
            "value":
                DateFormat('yyyy-MM-ddTHH:mm:ss-00:00').format(date).toString()
          }
        ],
        "field_where": [
          {"value": location}
        ],
        "langcode": [
          {"value": locale}
        ],
        "title": [
          {"value": title}
        ],
        "type": [
          {"target_id": "meetup", "target_type": "node_type"}
        ]
      };
      Map<String, String> headers = {};
      headers
        ..addAll(authHeader)
        ..addAll(jsonHeader)
        ..addAll(basicAuth)
        ..addAll(sessionHeader);

      var response = await http.post(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      debugPrint("Creating meetup: $_url");

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint(
            'Request failed with status: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
