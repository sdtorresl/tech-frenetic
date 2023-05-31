// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromJson(jsonString);

import 'dart:convert';

class PaymentMethodResponse {
  PaymentMethodResponse({
    this.id,
    this.object,
    this.billingDetails,
    this.card,
    this.created,
    this.customer,
    this.livemode,
    this.metadata,
    this.type,
  });

  final String? id;
  final String? object;
  final BillingDetails? billingDetails;
  final Card? card;
  final int? created;
  final dynamic customer;
  final bool? livemode;
  final Metadata? metadata;
  final String? type;

  factory PaymentMethodResponse.fromRawJson(String str) =>
      PaymentMethodResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        id: json["id"],
        object: json["object"],
        billingDetails: json["billing_details"] == null
            ? null
            : BillingDetails.fromJson(json["billing_details"]),
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
        created: json["created"],
        customer: json["customer"],
        livemode: json["livemode"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "billing_details": billingDetails?.toJson(),
        "card": card?.toJson(),
        "created": created,
        "customer": customer,
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "type": type,
      };
}

class BillingDetails {
  BillingDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
  });

  final Address? address;
  final dynamic email;
  final dynamic name;
  final dynamic phone;

  factory BillingDetails.fromRawJson(String str) =>
      BillingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "email": email,
        "name": name,
        "phone": phone,
      };
}

class Address {
  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  final dynamic city;
  final dynamic country;
  final dynamic line1;
  final dynamic line2;
  final dynamic postalCode;
  final dynamic state;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        line1: json["line1"],
        line2: json["line2"],
        postalCode: json["postal_code"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "line1": line1,
        "line2": line2,
        "postal_code": postalCode,
        "state": state,
      };
}

class Card {
  Card({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.generatedFrom,
    this.last4,
    this.networks,
    this.threeDSecureUsage,
    this.wallet,
  });

  final String? brand;
  final Checks? checks;
  final String? country;
  final int? expMonth;
  final int? expYear;
  final String? fingerprint;
  final String? funding;
  final dynamic generatedFrom;
  final String? last4;
  final Networks? networks;
  final ThreeDSecureUsage? threeDSecureUsage;
  final dynamic wallet;

  factory Card.fromRawJson(String str) => Card.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        brand: json["brand"],
        checks: json["checks"] == null ? null : Checks.fromJson(json["checks"]),
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        generatedFrom: json["generated_from"],
        last4: json["last4"],
        networks: json["networks"] == null
            ? null
            : Networks.fromJson(json["networks"]),
        threeDSecureUsage: json["three_d_secure_usage"] == null
            ? null
            : ThreeDSecureUsage.fromJson(json["three_d_secure_usage"]),
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "checks": checks?.toJson(),
        "country": country,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "generated_from": generatedFrom,
        "last4": last4,
        "networks": networks?.toJson(),
        "three_d_secure_usage": threeDSecureUsage?.toJson(),
        "wallet": wallet,
      };
}

class Checks {
  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  final dynamic addressLine1Check;
  final dynamic addressPostalCodeCheck;
  final String? cvcCheck;

  factory Checks.fromRawJson(String str) => Checks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
        addressLine1Check: json["address_line1_check"],
        addressPostalCodeCheck: json["address_postal_code_check"],
        cvcCheck: json["cvc_check"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1_check": addressLine1Check,
        "address_postal_code_check": addressPostalCodeCheck,
        "cvc_check": cvcCheck,
      };
}

class Networks {
  Networks({
    this.available,
    this.preferred,
  });

  final List<String>? available;
  final dynamic preferred;

  factory Networks.fromRawJson(String str) =>
      Networks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
        available: json["available"] == null
            ? []
            : List<String>.from(json["available"]!.map((x) => x)),
        preferred: json["preferred"],
      );

  Map<String, dynamic> toJson() => {
        "available": available == null
            ? []
            : List<dynamic>.from(available!.map((x) => x)),
        "preferred": preferred,
      };
}

class ThreeDSecureUsage {
  ThreeDSecureUsage({
    this.supported,
  });

  final bool? supported;

  factory ThreeDSecureUsage.fromRawJson(String str) =>
      ThreeDSecureUsage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) =>
      ThreeDSecureUsage(
        supported: json["supported"],
      );

  Map<String, dynamic> toJson() => {
        "supported": supported,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromRawJson(String str) =>
      Metadata.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
