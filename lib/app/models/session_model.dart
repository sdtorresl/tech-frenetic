import 'dart:convert';

class SessionModel {
  SessionModel({
    this.currentUser,
    this.csrfToken,
    this.logoutToken,
  });

  CurrentUserModel? currentUser;
  String? csrfToken;
  String? logoutToken;

  factory SessionModel.fromJson(String str) =>
      SessionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SessionModel.fromMap(Map<String, dynamic> json) => SessionModel(
        currentUser: json["current_user"] == null
            ? null
            : CurrentUserModel.fromMap(json["current_user"]),
        csrfToken: json["csrf_token"],
        logoutToken: json["logout_token"],
      );

  Map<String, dynamic> toMap() => {
        "current_user": currentUser == null ? null : currentUser!.toMap(),
        "csrf_token": csrfToken,
        "logout_token": logoutToken,
      };

  @override
  String toString() {
    return toJson();
  }
}

class CurrentUserModel {
  CurrentUserModel({
    required this.uid,
    required this.name,
  });

  String uid;
  String name;

  factory CurrentUserModel.fromJson(String str) =>
      CurrentUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentUserModel.fromMap(Map<String, dynamic> json) =>
      CurrentUserModel(
        uid: json["uid"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
      };

  @override
  toString() => toJson();
}
