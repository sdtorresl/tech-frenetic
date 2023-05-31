// To parse this JSON data, do
//
//     final groupUserModel = groupUserModelFromJson(jsonString);

import 'dart:convert';

class GroupUserModel {
  GroupUserModel({
    required this.name,
    required this.uid,
  });

  final String name;
  final String uid;

  factory GroupUserModel.fromRawJson(String str) =>
      GroupUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupUserModel.fromJson(Map<String, dynamic> json) => GroupUserModel(
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
      };

  @override
  bool operator ==(Object other) {
    if (other is GroupUserModel) {
      return uid == other.uid && name == other.name;
    }
    return false;
  }

  @override
  int get hashCode => uid.hashCode;
}
