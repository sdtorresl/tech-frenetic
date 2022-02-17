import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class CreateMeetupProvider extends TechFreneticProvider {
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
      debugPrint(
          DateFormat('yyyy-MM-ddTHH:mm:ss-SSSXXX').format(date).toString());
      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(jsonHeader);
      headers.addAll(basicAuth);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
