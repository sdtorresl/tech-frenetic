import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/terms_and_privacy_policy_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/tf_provider.dart';

class PrivacyPolicyProvider extends TechFreneticProvider {
  Future<TermsAndPolicyModel> getPolicyPrivacy() async {
    TermsAndPolicyModel policyPrivacy = TermsAndPolicyModel.empty();

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/page?_format=json&alias=/privacy-policy");
      debugPrint(_url.toString());
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        debugPrint(response.body.toString());
        if (jsonResponse.isNotEmpty) {
          policyPrivacy = TermsAndPolicyModel.fromMap(jsonResponse[0]);
          debugPrint(policyPrivacy.toString());
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return policyPrivacy;
  }
}
