// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

import 'package:techfrenetic/app/models/model.dart';

class ContactModel extends Model {
  ContactModel({
    this.webformId = "contact",
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.subject,
  });

  String webformId;
  String name;
  String email;
  String phone;
  String message;
  String subject;

  factory ContactModel.fromJson(String str) =>
      ContactModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactModel.fromMap(Map<String, dynamic> json) => ContactModel(
        webformId: json["webform_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        message: json["message"],
        subject: json["subject"],
      );

  Map<String, dynamic> toMap() => {
        "webform_id": webformId,
        "name": name,
        "email": email,
        "phone": phone,
        "message": message,
        "subject": subject,
      };

  @override
  String toString() {
    return toJson();
  }
}
