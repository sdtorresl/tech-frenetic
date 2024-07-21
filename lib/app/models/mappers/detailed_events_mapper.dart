import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/extensions/string_utils.dart';
import 'package:techfrenetic/app/models/detailed_event_model.dart';

final String baseUrl = GlobalConfiguration().getValue("api_url");

class DetailedEventMapper {
  static DetailedEventModel fromMap(Map<String, dynamic> json) {
    String? picture =
        json["field_image"] == null || (json["field_image"] as String).isEmpty
            ? null
            : baseUrl + json["field_image"];

    String? ticketLink =
        (json["field_tickets"] as String).getAttributeValue('href', 'a');

    return DetailedEventModel(
      id: json['nid'],
      slug: (json["field_path"] as String).split('/').last,
      eventName: json['field_name_evente'],
      image: picture,
      category: json['field_principal_category'],
      summary: json['field_our_recommendation'],
      longDescription: (json['body'] as String).parseHtmlString(),
      location: json['field_location'],
      startDate: DateTime.parse(json['field_start_date']),
      endDate: DateTime.parse(json['field_end_date']),
      ticketLink: ticketLink,
    );
  }

  DetailedEventModel fromJson(String str) => fromMap(json.decode(str));
}
