import 'dart:convert';

import 'model.dart';

class TermsAndPolicyModel extends Model {
  TermsAndPolicyModel({
    required this.id,
    required this.title,
    required this.body,
  });

  int id;
  String title;
  String body;

  factory TermsAndPolicyModel.fromJson(String str) =>
      TermsAndPolicyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TermsAndPolicyModel.fromMap(Map<String, dynamic> json) =>
      TermsAndPolicyModel(
        id: int.tryParse(json["id"]) ?? -1,
        title: json["title"],
        body: json["body"],
      );

  factory TermsAndPolicyModel.empty() => TermsAndPolicyModel(
        id: -1,
        title: "",
        body: "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
