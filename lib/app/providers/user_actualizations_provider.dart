import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/providers/tf_provider.dart';

class UserActualizationsProvider extends TechFreneticProvider {
  Future<bool?> userUpdate(DateTime birthdate, String cellphone, String country,
      String email) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=hal_json");

      Map<String, dynamic> body = {
        "field_birthdate": {"value": birthdate.toString()},
        "field_cellphone": {"value": cellphone},
        "field_user_location": {"value": country},
        "mail": {"value": email}
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.patch(
        _url,
        body: json.encode(body),
        headers: headers,
      );
      debugPrint(response.statusCode.toString());

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
