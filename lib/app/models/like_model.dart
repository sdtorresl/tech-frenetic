import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

class LikeModel extends Model {
  LikeModel({
    required this.id,
  });

  final int id;

  factory LikeModel.fromJson(String str) => LikeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikeModel.fromMap(Map<String, dynamic> json) {
    int id = json["id"][0]["value"];
    return LikeModel(
      id: id,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
      };
  @override
  String toString() => toJson();
}
