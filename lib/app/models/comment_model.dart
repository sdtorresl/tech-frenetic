import 'dart:convert';

import 'model.dart';

class CommentModel extends Model {
  CommentModel({
    required this.id,
    required this.body,
    required this.date,
    required this.author,
    required this.user,
    required this.likes,
  });

  int id;
  String body;
  DateTime date;
  String author;
  String user;
  int likes;

  factory CommentModel.fromJson(String str) =>
      CommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        id: int.tryParse(json["id"]) ?? -1,
        body: json["body"],
        date: DateTime.parse(json["date"]),
        author: json["author"],
        user: json["user"],
        likes: (int.tryParse(json["likes"]) ?? 0),
      );

  factory CommentModel.empty() => CommentModel(
        id: -1,
        body: "",
        date: DateTime.now(),
        author: "",
        user: "",
        likes: 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "date": date.toIso8601String(),
        "author": author,
        "user": user,
        "likes": likes,
      };
}
