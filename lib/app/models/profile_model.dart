// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

class ProfileModel extends Model {
  ProfileModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.displayName,
    required this.picture,
    required this.date,
    required this.avatar,
    required this.location,
    required this.type,
    required this.role,
    required this.useAvatar,
    required this.certifications,
    required this.interests,
    required this.fullBio,
    required this.birthdate,
    required this.cellphone,
    required this.fieldProfessions,
    required this.fieldCountry,
  });

  String id;
  String name;
  String bio;
  String displayName;
  String picture;
  DateTime date;
  String avatar;
  String location;
  String type;
  String role;
  bool useAvatar;
  String certifications;
  String interests;
  String fullBio;
  String birthdate;
  String cellphone;
  String fieldProfessions;
  String fieldCountry;

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      bio: json["bio"] ?? '',
      displayName: json["display_name"] ?? '',
      picture: json["picture"] ?? '',
      date:
          json["date"] != null ? DateTime.parse(json["date"]) : DateTime.now(),
      avatar: json["avatar"] ?? '',
      location: json["location"] ?? '',
      type: json["type"] ?? '',
      role: json["role"] ?? '',
      useAvatar: json["avatar"] != "",
      certifications: json["certifications"] ?? '',
      interests: json["interests"] ?? '',
      fullBio: json["full_bio"] ?? '',
      birthdate: json["birthdate"] ?? '',
      cellphone: json["cellphone"] ?? '',
      fieldProfessions: json["field__professions"] ?? '',
      fieldCountry: json["field_country"] ?? '',
    );
  }

  factory ProfileModel.empty() => ProfileModel(
      avatar: '',
      bio: '',
      birthdate: '',
      cellphone: '',
      certifications: '',
      date: DateTime.now(),
      displayName: '',
      fieldCountry: '',
      fieldProfessions: '',
      fullBio: '',
      id: '',
      interests: '',
      location: '',
      name: '',
      picture: '',
      role: '',
      type: '',
      useAvatar: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "display_name": displayName,
        "picture": picture,
        "date": date.toIso8601String(),
        "avatar": avatar,
        "location": location,
        "type": type,
        "role": role,
        "use_avatar": useAvatar,
        "certifications": certifications,
        "interests": interests,
        "full_bio": fullBio,
        "birthdate": birthdate,
        "cellphone": cellphone,
        "field__professions": fieldProfessions,
        "field_country": fieldCountry,
      };

  @override
  String toString() {
    return toRawJson();
  }
}
