import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/models/speaker_model.dart';
import 'package:techfrenetic/app/models/sponsors_model.dart';

class DetailedEventModel extends EventsModel {
  final String? longDescription;
  List<SpeakerModel> speakers;
  List<SponsorModel> sponsors;

  DetailedEventModel({
    required super.id,
    required super.slug,
    required super.eventName,
    required super.image,
    required super.category,
    required super.summary,
    required super.location,
    required super.startDate,
    required super.endDate,
    this.longDescription,
    this.speakers = const [],
    this.sponsors = const [],
  });
}
