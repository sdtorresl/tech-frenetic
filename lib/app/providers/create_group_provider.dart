import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/providers/tf_provider.dart';

class CreateGroupProvider extends TechFreneticProvider {
  Future<bool?> createGroup(String name, String description, String rules,
      String namePerson, String type) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/entity/node?_format=json");

      Map<String, dynamic> body = {
        "type": [
          {"target_id": "group", "target_type": "node_type"}
        ],
        "title": [
          {"value": name}
        ],
        "langcode": [
          {"value": locale}
        ],
        "field_group_featured": [
          {"value": "0"}
        ],
        "field_group_logo": [
          {"target_id": "11", "alt": "Assassins-Creed-Valhalla-1"}
        ],
        "field_group_members": [
          {"value": "tfadmin (1)"}
        ],
        "field_group_rules": [
          {"value": rules}
        ],
        "field_group_articles": [
          {"value": "PlayStation 5: Black"}
        ],
        "field_group_description": [
          {"value": description}
        ]
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(basicAuth);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        debugPrint(response.body);
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