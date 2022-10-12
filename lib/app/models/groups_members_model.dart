import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/model.dart';

class GroupMembersModel extends Model {
  GroupMembersModel({
    required this.groupMembers,
  });

  final List<MemberModel> groupMembers;

  factory GroupMembersModel.fromJson(String str) =>
      GroupMembersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupMembersModel.fromMap(Map<String, dynamic> json) {
    String members = Model.returnObject(json["field_group_members"], []);
    debugPrint(members.toString());
    return GroupMembersModel(
      groupMembers: json["field_group_members"],
    );
  }
  factory GroupMembersModel.empty() => GroupMembersModel(
        groupMembers: [],
      );
  Map<String, dynamic> toMap() => {
        "field_group_members": groupMembers,
      };
  @override
  String toString() => toJson();
}

class MemberModel extends Model {
  MemberModel({
    required this.userid,
    required this.targetType,
    required this.targetUuid,
    required this.url,
  });

  final int userid;
  final String targetType;
  final String targetUuid;
  final String url;

  factory MemberModel.fromJson(String str) =>
      MemberModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MemberModel.fromMap(Map<String, dynamic> json) {
    return MemberModel(
      userid: json["target_id"],
      targetType: json["target_type"],
      targetUuid: json["target_uuid"],
      url: json["url"],
    );
  }
  factory MemberModel.empty() => MemberModel(
        userid: 0,
        targetType: '',
        targetUuid: '',
        url: '',
      );
  Map<String, dynamic> toMap() => {
        "target_id": userid,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
  @override
  String toString() => toJson();
}
