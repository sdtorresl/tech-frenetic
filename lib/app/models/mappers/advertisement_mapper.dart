import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

import '../advertisement_model.dart';

final String baseUrl = GlobalConfiguration().getValue("api_url");

class AdvertisementMapper {
  static AdvertisementModel fromJson(String str) => fromMap(json.decode(str));

  static AdvertisementModel fromMap(Map<String, dynamic> json) {
    String? picture = json["field_imagen"];
    if (picture != null && (picture).isNotEmpty) {
      picture = baseUrl + json["field_imagen"];
    }
    return AdvertisementModel(
      picture: picture,
      link: json["field_enlace_1"],
      video: json["field_videos"],
      isVideo: json["field_videos"] != null &&
          (json["field_videos"] as String).isNotEmpty,
    );
  }
}
