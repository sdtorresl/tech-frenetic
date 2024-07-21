import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/detailed_event_model.dart';
import 'package:techfrenetic/app/models/dtos/event_filter_dto.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/models/mappers/detailed_events_mapper.dart';
import 'package:techfrenetic/app/models/speaker_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class EventsProvider extends TechFreneticProvider {
  Future<List<EventsModel>> getFeaturedEvents() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-featured");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<EventsModel> events = [];

        for (var item in jsonResponse) {
          EventsModel event = EventsModel.fromMap(item);
          events.add(event);
        }
        return events;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<EventsModel>> getUpcomingEvents({EventFilterDto? filter}) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-upcomming");
      if (filter != null) {
        _url = _url.replace(queryParameters: filter.getQueryParams);
      }
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        return jsonResponse.map((e) => EventsModel.fromMap(e)).toList();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<EventsModel>> getRecentEvents({EventFilterDto? filter}) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-recent");
      if (filter != null) {
        _url = _url.replace(queryParameters: filter.getQueryParams);
      }
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        return jsonResponse.map((e) => EventsModel.fromMap(e)).toList();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<DetailedEventModel?> getEvent(String slug) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/v1/events?alias=/$slug");

      debugPrint(_url.toString());

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        DetailedEventModel detailedEvent =
            DetailedEventMapper.fromMap(jsonResponse.first);

        var speakers = await getEventSpeakers(slug);
        detailedEvent.speakers = speakers;

        return detailedEvent;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  Future<List<SpeakerModel>> getEventSpeakers(String slug) async {
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/events-speakers?alias=/$slug");

      debugPrint(_url.toString());

      var response = await http.get(_url);

      if (response.statusCode == 200) {
        //List<dynamic> jsonResponse = json.jsonDecode(response.body);

        /* PaginatorDto paginator =
            PaginatorDto.fromMap(jsonResponse, DetailedEventMapper.fromMap); */

        return List.generate(
            5,
            ((index) => SpeakerModel(
                  "Anita Jhonson $index",
                  "At nunc ut et risus volutpat volutpat ullamcorper at pharetra. Diam ac vitae mollis nullam curabitur congue parturient venenatis, in. At sed massa ultricies et vivamus nulla mattis eu vulputate. Amet, purus, ridiculus scelerisque sapien, dictum viverra. A id orci, eleifend porttitor tristique feugiat feugiat pellentesque eu.",
                  'https://dev-techfrenetic.us.seedcloud.co/api/sites/default/files/styles/thumbnail/public/2023-04/Rectangle%20705_0.png?itok=X8mbeCoQ',
                  'Sidney, AU',
                )));
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }

  Future<EventsModel?> getRecentEvent() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/last-event");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        return EventsModel.fromMap(jsonResponse.first);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
