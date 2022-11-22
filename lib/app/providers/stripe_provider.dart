import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/providers/tf_provider.dart';

class StripeProvider extends TechFreneticProvider {
  Future<String?> createCheckout() async {
    String? sessionId;

    try {
      Uri _url = Uri.parse("$baseUrl/api/en/get-stripe-session");

      var response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        sessionId = jsonResponse["id"];
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return sessionId;
  }
}
