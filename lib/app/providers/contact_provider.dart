import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/contact_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class ContactProvider extends TechFreneticProvider {
  Future<bool> sendContact(ContactModel contactData) async {
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/webform_rest/submit?_format=json");

      String body = contactData.toJson();

      Map<String, String> headers = authHeader
        ..addAll(jsonHeader)
        ..addAll(basicAuth)
        ..addAll(sessionHeader);

      var response = await http.post(
        _url,
        body: body,
        headers: headers,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
            'Request failed with status: ${response.statusCode}. Output: ${response.body}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
}
