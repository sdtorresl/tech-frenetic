import 'package:flutter/material.dart';
import 'dart:convert';
import 'model.dart';
import 'package:global_configuration/global_configuration.dart';

class EventsModel extends Model {
  EventsModel({
    required this.id,
    required this.slug,
    required this.eventName,
    required this.image,
    required this.category,
    required this.summary,
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  final id;
  final String slug;
  String eventName;
  String? image;
  String category;
  String summary;
  String location;
  DateTime startDate;
  DateTime endDate;

  factory EventsModel.fromJson(String str) =>
      EventsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventsModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");
    String image = _baseUrl + json["field_image"];
    debugPrint(image);

    return EventsModel(
      id: int.tryParse(json["nid"]) ?? -1,
      slug: (json["field_path"] as String).split('/').last,
      eventName: json["field_name_evente"],
      image: _baseUrl + json["field_image"],
      category: json["field_principal_category"],
      summary: json["field_summary_short"],
      location: json["field_location"],
      startDate: DateTime.parse(json["field_start_date"]),
      endDate: DateTime.parse(json["field_end_date"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "nid": id,
        "field_name_evente": eventName,
        "field_image": image,
        "field_principal_category": category,
        "field_summary_short": summary,
        "field_location": location,
        "field_start_date": startDate.toIso8601String(),
        "field_end_date": endDate.toIso8601String(),
      };
}
