import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class FeaturedEventsProvider extends TechFreneticProvider {
  Future<List<EventsModel>> getFeaturedEvents() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-featured");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = json.jsonDecode(response.body);
          List<EventsModel> events = [];

          for (var item in jsonResponse) {
            EventsModel event = EventsModel.fromMap(item);
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
