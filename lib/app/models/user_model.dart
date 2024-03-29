import 'dart:convert';
import 'package:global_configuration/global_configuration.dart';
import 'package:techfrenetic/app/models/model.dart';

class UserModel extends Model {
  UserModel({
    required this.avatar,
    required this.certifications,
    required this.created,
    this.interests = const [],
    required this.location,
    required this.mail,
    required this.name,
    required this.profession,
    required this.type,
    required this.uid,
    required this.useAvatar,
    required this.userName,
    this.biography = '',
    this.birthdate,
    this.cellphone,
    this.changed,
    this.company = '',
    this.contentTranslationCreated,
    this.country,
    this.dateSavePassword,
    this.following,
    this.kind,
    this.langcode,
    this.picture,
    this.uuid,
  }) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");
    picture = (picture ?? "").isNotEmpty ? baseUrl + picture! : null;
  }

  bool useAvatar;
  DateTime? birthdate;
  DateTime? changed;
  DateTime? contentTranslationCreated;
  DateTime? contentTranslationUid;
  DateTime? created;
  DateTime? dateSavePassword;
  int uid;
  String? picture;
  List<InterestModel> interests;
  List<String> certifications;
  String avatar;
  String biography;
  String? company;
  String? contentTranslationSource;
  String name;
  String profession;
  String userName;
  String? uuid;
  String? country;
  String? cellphone;
  String? following;
  String? kind;
  String? langcode;
  String? location;
  String? mail;
  String? type;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));
  factory UserModel.fromJsonProfile(String str) =>
      UserModel.fromProfileMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromProfileMap(Map<String, dynamic> json) => UserModel(
        avatar: json["avatar"],
        biography: json["full_bio"],
        birthdate: DateTime.parse(json["date"]),
        cellphone: json["cellphone"].toString(),
        certifications: [],
        country: json["field_country"],
        created: DateTime.parse(json["date"]),
        location: json["location"],
        mail: json["custom_user_email"],
        name: json["display_name"],
        picture: json["picture"],
        profession: json["field__professions"],
        type: json["type"],
        uid: json["id"],
        useAvatar: json["use_avatar"] == "True",
        userName: json["name"],
      );

  factory UserModel.fromMap(Map<String, dynamic> json) {
    int uid = int.parse((Model.returnValue(json["uid"], 0) ?? 0).toString());
    String createdStr = Model.returnValue(json['created'], "null");
    String changedStr = Model.returnValue(json['changed'], "null");
    String contentTranslationCreatedStr =
        Model.returnValue(json['content_translation_created'], "null");
    String birthDateStr = Model.returnValue(json['field_birthdate'], "null");
    String dateSavePasswordStr =
        Model.returnValue(json['field_date_save_password'], 'null');

    bool useAvatar = json["field_use_avatar"] is String
        ? json["field_use_avatar"] == "True"
        : Model.returnValue(json["field_use_avatar"], false);

    /* List<FileModel> picture = [];
    if (json["user_picture"] is String) {
      picture = [FileModel(targetId: 1, url: json["user_picture"])];
    } else {
      picture = json["user_picture"] == null
          ? []
          : List<FileModel>.from(
              json["user_picture"].map((x) => FileModel.fromMap(x)));
    } */

    return UserModel(
      uid: uid,
      uuid: Model.returnValue(json["uuid"], ''),
      langcode: Model.returnValue(json["langcode"], ''),
      userName: Model.returnValue(json["name"], ''),
      mail: Model.returnValue(json["mail"], ''),
      created: DateTime.tryParse(createdStr),
      changed: DateTime.tryParse(changedStr),
      contentTranslationCreated:
          DateTime.tryParse(contentTranslationCreatedStr),
      biography: Model.returnValue(json["field_biography"], ''),
      birthdate: DateTime.tryParse(birthDateStr),
      cellphone: Model.returnValue(json["field_cellphone"], ''),
      certifications: List<String>.from(
        Model.returnValue(json["field_certifications"], [], isList: true),
      ),
      company: Model.returnValue(json["field_company"], ''),
      dateSavePassword: DateTime.tryParse(dateSavePasswordStr),
      following: Model.returnValue(json["field_following"], ''),
      interests: json["field_interests"] == null
          ? []
          : List<InterestModel>.from(
              json["field_interests"].map((x) => InterestModel.fromMap(x)),
            ),
      name: Model.returnValue(json["field_name"], ''),
      avatar: Model.returnValue(json["field_user_avatar"], ''),
      kind: Model.returnValue(json["field_user_kind"], ''),
      location: Model.returnValue(json["field_user_location"], ''),
      profession: Model.returnValue(json["field_user_profession"], ''),
      type: Model.returnValue(json["field_user_type"], ''),
      useAvatar: useAvatar,
    );
  }

  factory UserModel.empty() => UserModel(
        birthdate: null,
        biography: '',
        cellphone: '',
        changed: null,
        company: '',
        contentTranslationCreated: null,
        created: null,
        dateSavePassword: null,
        certifications: [],
        following: '',
        interests: [],
        avatar: '',
        langcode: '',
        mail: '',
        name: '',
        uid: 0,
        useAvatar: true,
        kind: '',
        location: '',
        userName: '',
        picture: null,
        profession: '',
        type: '',
        uuid: '',
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "uuid": uuid,
        "langcode": langcode,
        "name": userName,
        "mail": mail,
        "created": created != null ? created!.toIso8601String() : created,
        "changed": changed != null ? changed!.toIso8601String() : changed,
        "content_translation_created": contentTranslationCreated != null
            ? contentTranslationCreated!.toIso8601String()
            : contentTranslationCreated,
        "field_biography": biography,
        "field_birthdate":
            birthdate != null ? birthdate!.toIso8601String() : birthdate,
        "field_cellphone": cellphone,
        "field_certifications": certifications,
        "field_company": company,
        "field_date_save_password": dateSavePassword != null
            ? dateSavePassword!.toIso8601String()
            : dateSavePassword,
        "field_following": following,
        "field_interests": interests,
        "field_name": name,
        "field_user_avatar": avatar,
        "field_user_kind": kind,
        "field_user_location": location,
        "field_user_profession": profession,
        "field_user_type": type,
        "field_use_avatar": useAvatar,
        "user_picture": picture
      };

  @override
  toString() => toJson();
}

class InterestModel extends Model {
  InterestModel({
    required this.id,
    required this.type,
    this.uuid,
    this.url,
  });

  int id;
  String type;
  String? uuid;
  String? url;

  factory InterestModel.fromJson(String str) =>
      InterestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InterestModel.fromMap(Map<String, dynamic> json) {
    return InterestModel(
      id: json["target_id"],
      type: json["target_type"],
      uuid: json["target_uuid"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toMap() => {"target_id": id, "target_type": type};

  @override
  toString() => toJson();
}
