import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/vendor_description.dart';

final String baseUrl = GlobalConfiguration().getValue("api_url");

class VendorDescriptionMapper {
  static VendorDescriptionModel fromMap(Map<String, dynamic> json) {
    String image1 = baseUrl + json["field_image_one"];
    String image2 = baseUrl + json["field_image_three"];
    String image3 = baseUrl + json["field_image_two"];

    return VendorDescriptionModel(
        title: json['title'],
        description: json['body'],
        image1: image1,
        image2: image2,
        image3: image3);
  }

  VendorDescriptionModel fromJson(String str) => fromMap(json.decode(str));
}
