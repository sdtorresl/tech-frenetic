import 'dart:convert' as json;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/credit_card_model.dart';
import 'package:techfrenetic/app/models/payment_method_response.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class PaymentsProvider extends TechFreneticProvider {
  String _authentication() {
    String username = GlobalConfiguration().getValue('stripe_key');
    String password = '';
    String basicAuthValue =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return basicAuthValue;
  }

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

  Future<PaymentMethodResponse> addPaymentMethod(
      String cardNumber, int expMonth, int expYear, String cvc) async {
    Map<String, String> headers = {
      'Authorization': _authentication(),
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Uri _url = Uri.parse("https://api.stripe.com/v1/payment_methods");
    Map<String, String> body = {
      'type': 'card',
      'card[number]': cardNumber,
      'card[exp_month]': expMonth.toString(),
      'card[exp_year]': expYear.toString(),
      'card[cvc]': cvc
    };

    var response = await http.post(_url, body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
      return PaymentMethodResponse.fromJson(jsonResponse);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> createOrder(UserModel user, CreditCardModel card) async {
    Map<String, String> headers = authHeader
      ..addAll(sessionHeader)
      ..addAll(jsonHeader);

    Uri _url = Uri.parse("$baseUrl/api/$locale/commerce/order/create");
    Map<String, dynamic> body = {
      "order": {
        "type": "default",
        "email": user.mail,
        "store": 1,
        "order_items": [
          {
            "type": "default",
            "title": "Knit Hat in Midnight Plumkkkk",
            "quantity": 1,
            "purchased_entity": {"sku": "TFPREMIUM"},
            "unit_price": {"number": 10, "currency_code": "USD"}
          }
        ]
      },
      "user": {"mail": user.mail, "name": user.userName, "status": "TRUE"},
      "payment": {
        "gateway": "pago_premium",
        "type": "credit_card",
        "details": {
          "type": "credit_card",
          "expiration": {
            "month": card.month.toString(),
            "year": card.year.toString()
          },
          "stripe_payment_method_id": card.stripePaymentId
        }
      }
    };

    var response =
        await http.post(_url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}
