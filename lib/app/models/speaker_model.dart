import 'package:techfrenetic/app/models/model.dart';

class SpeakerModel extends Model {
  final String name;
  final String description;
  final String location;
  final String picture;

  SpeakerModel(this.name, this.description, this.picture, this.location);
}
