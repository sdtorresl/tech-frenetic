import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

class LikeModel extends Model {
  LikeModel({
    required this.id,
  });

  final Map<String, dynamic> id;

  factory LikeModel.fromJson(String str) => LikeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikeModel.fromMap(Map<String, dynamic> json) {
    return LikeModel(
      id: Model.returnObject(json["id"], []),
    );
  }
  factory LikeModel.empty() => LikeModel(
        id: {},
      );
  Map<String, dynamic> toMap() => {
        "id": id,
      };
  @override
  String toString() => toJson();
}

class LikeValueModel extends Model {
  LikeValueModel({
    required this.value,
  });

  final int value;

  factory LikeValueModel.fromJson(String str) =>
      LikeValueModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikeValueModel.fromMap(Map<String, dynamic> json) {
    return LikeValueModel(value: json["value"]);
  }
  factory LikeValueModel.empty() => LikeValueModel(
        value: 0,
      );
  Map<String, dynamic> toMap() => {
        "value": value,
      };
  @override
  String toString() => toJson();
}
