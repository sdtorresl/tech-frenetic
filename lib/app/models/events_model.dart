import 'package:flutter/material.dart';
import 'dart:convert';
import 'model.dart';
import 'package:global_configuration/global_configuration.dart';

class EventsModel extends Model {
  EventsModel({
    required this.nid,
    required this.eventName,
    required this.image,
    required this.category,
    required this.summary,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.filePath,
  });

  int nid;
  String eventName;
  String? image;
  String category;
  String summary;
  String location;
  DateTime startDate;
  DateTime endDate;
  String filePath;

  factory EventsModel.fromJson(String str) =>
      EventsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventsModel.fromMap(Map<String, dynamic> json) {
    final String _baseUrl = GlobalConfiguration().getValue("api_url");
    String image = _baseUrl + json["field_image"];
    debugPrint(image);

    return EventsModel(
      nid: int.tryParse(json["nid"]) ?? -1,
      eventName: json["field_name_evente"],
      image: _baseUrl + json["field_image"],
      category: json["field_principal_category"],
      summary: json["field_summary_short"],
      location: json["field_location"],
      startDate: DateTime.parse(json["field_start_date"]),
      endDate: DateTime.parse(json["field_end_date"]),
      filePath: json["field_path"],
    );
  }
  factory EventsModel.empty() => EventsModel(
        nid: -1,
        eventName: "",
        image: "",
        category: "",
        summary: "",
        location: "",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        filePath: "",
      );

  Map<String, dynamic> toMap() => {
        "nid": nid,
        "field_name_evente": eventName,
        "field_image": image,
        "field_principal_category": category,
        "field_summary_short": summary,
        "field_location": location,
        "field_start_date": startDate.toIso8601String(),
        "field_end_date": endDate.toIso8601String(),
        "field_path": filePath,
      };
}
