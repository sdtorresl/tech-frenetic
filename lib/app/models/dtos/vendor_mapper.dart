// To parse this JSON data, do
//
//     final vendorDto = vendorDtoFromMap(jsonString);

import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';

final String baseUrl = GlobalConfiguration().getValue("api_url");

VendorModel fromMap(Map<String, dynamic> json) {
  String? picture =
      json["field_photo"] == null || (json["field_photo"] as String).isEmpty
          ? null
          : baseUrl + json["field_photo"];

  return VendorModel(
    description: json["field_title_body"] ?? "",
    longDescription: json["body"],
    email: json["field_correo"],
    location: json["field_country"],
    category: json["field_services_vendors"],
    phone: json["field_phone"],
    picture: picture,
    webpage: json["field_sitio_web"],
    id: int.parse(json["nid"] as String),
    title: json["title"],
  );
}

VendorModel fromJson(String str) => fromMap(json.decode(str));
