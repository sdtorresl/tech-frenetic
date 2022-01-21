import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/model.dart';

class ArticleDetailsModel extends Model {
  ArticleDetailsModel({
    required this.revisionUid,
  });

  final UserByArticleModel revisionUid;

  factory ArticleDetailsModel.fromJson(String str) =>
      ArticleDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleDetailsModel.fromMap(Map<String, dynamic> json) {
    return ArticleDetailsModel(
      revisionUid: Model.returnObject(
        List<UserByArticleModel>.from(
          json["revision_uid"].map((x) => UserByArticleModel.fromMap(x)),
        ),
        UserByArticleModel.empty(),
      ),
    );
  }
  factory ArticleDetailsModel.empty() => ArticleDetailsModel(
        revisionUid: UserByArticleModel.empty(),
      );
  Map<String, dynamic> toMap() => {
        "revision_uid": revisionUid,
      };
  @override
  String toString() => toJson();
}

class UserByArticleModel extends Model {
  UserByArticleModel({
    required this.targetId,
    required this.targetType,
    required this.targetUuid,
    required this.url,
  });

  final int targetId;
  final String targetType;
  final String targetUuid;
  final String url;

  factory UserByArticleModel.fromJson(String str) =>
      UserByArticleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserByArticleModel.fromMap(Map<String, dynamic> json) {
    return UserByArticleModel(
      targetId: json["target_id"],
      targetType: json["target_type"],
      targetUuid: json["target_uuid"],
      url: json["url"],
    );
  }
  factory UserByArticleModel.empty() => UserByArticleModel(
        targetId: 0,
        targetType: '',
        targetUuid: '',
        url: '',
      );
  Map<String, dynamic> toMap() => {
        "target_id": targetId,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
  @override
  String toString() => toJson();
}
