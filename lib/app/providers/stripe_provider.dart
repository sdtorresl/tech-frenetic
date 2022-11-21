import 'dart:convert' as json;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StripeProvider {
  Future<String?> createCheckout() async {
    String? sessionId;

    try {
      Uri _url = Uri.parse("https://stripe-2702.twil.io/create_checkout");

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
