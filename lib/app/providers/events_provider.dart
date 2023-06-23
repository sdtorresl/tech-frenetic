import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/detailed_event_model.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/models/speaker_model.dart';
import 'package:techfrenetic/app/models/sponsors_model.dart';
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

  Future<List<EventsModel>> getUpcomingEvents() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-upcomming");
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

  Future<List<EventsModel>> getRecentEvents() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/events-recent");
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

  Future<DetailedEventModel?> getEvent(int eventId) {
    var speakers = List.generate(
        3,
        ((index) => SpeakerModel(
              "Anita Jhonson ",
              "At nunc ut et risus volutpat volutpat ullamcorper at pharetra. Diam ac vitae mollis nullam curabitur congue parturient venenatis, in. At sed massa ultricies et vivamus nulla mattis eu vulputate. Amet, purus, ridiculus scelerisque sapien, dictum viverra. A id orci, eleifend porttitor tristique feugiat feugiat pellentesque eu.",
              'https://dev-techfrenetic.us.seedcloud.co/api/sites/default/files/styles/thumbnail/public/2023-04/Rectangle%20705_0.png?itok=X8mbeCoQ',
              'Sidney, AU',
            )));

    var sponsors = List.generate(
        6,
        ((index) => SponsorModel(
              picture:
                  'https://dev-techfrenetic.us.seedcloud.co/api/sites/default/files/styles/thumbnail/public/2023-04/Rectangle%20705_0.png?itok=X8mbeCoQ',
            )));

    return Future.value(
      DetailedEventModel(
        nid: 12,
        eventName: 'My Event',
        image:
            'https://dev-techfrenetic.us.seedcloud.co/api/sites/default/files/styles/thumbnail/public/2023-04/Rectangle%20705_0.png?itok=X8mbeCoQ',
        category: 'Cybersecurity',
        summary:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam nisi nulla, feugiat ut efficitur sed, faucibus ut dolor. Nullam tempus sapien sed tortor molestie porta",
        location: "Bogotá, Colombia",
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        filePath:
            "/api/en/name-of-the-event-lorem-ipsum-dolor-sit-amet-consectetur",
        speakers: speakers,
        sponsors: sponsors,
        longDescription:
            "Enim parturient id diam integer nisl vivamus. Arcu ut bibendum dolor euismod lectus a molestie eu. Lacus eu neque, egestas ornare nisl, lacus.\n\nAt nunc ut et risus volutpat volutpat ullamcorper at pharetra. Diam ac vitae mollis nullam curabitur congue parturient venenatis, in. At sed massa ultricies et vivamus nulla mattis eu vulputate. Amet, purus, ridiculus scelerisque sapien, dictum viverra. A id orci, eleifend porttitor tristique feugiat feugiat pellentesque eu. Consequat donec amet fermentum mattis velit. Est proin lacus, sed eget in fringilla id vestibulum.\n\nA duis auctor blandit ultricies ultrices augue. Sagittis, fringilla dictum luctus malesuada massa hendrerit morbi. Nulla eleifend massa mauris turpis. Sem enim posuere nunc elementum lacus. Est imperdiet in viverra augue. Lacinia aliquam vel pharetra, orci urna ultrices tristique at sed. Egestas semper elementum lacus, nisl.\nVestibulum, lectus vel venenatis faucibus. Mauris, nibh id dolor lacus, faucibus posuere. Aliquet id porta dui eget purus sollicitudin. Praesent cursus mauris tellus proin volutpat. Malesuada massa consectetur lorem sit nulla nam. Duis et, enim, amet at nec. Bibendum sit faucibus aliquam ut vitae platea elit feugiat.",
      ),
    );
  }
}
