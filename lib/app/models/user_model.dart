import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/model.dart';

import 'file_model.dart';

class UserModel extends Model {
  UserModel({
    required this.uid,
    required this.uuid,
    required this.langcode,
    required this.userName,
    required this.mail,
    required this.created,
    required this.changed,
    required this.defaultLangcode,
    required this.contentTranslationSource,
    required this.contentTranslationOutdated,
    required this.contentTranslationUid,
    required this.contentTranslationStatus,
    required this.contentTranslationCreated,
    required this.biography,
    required this.birthdate,
    required this.cellphone,
    required this.certifications,
    required this.company,
    required this.dateSavePassword,
    required this.following,
    required this.interests,
    required this.name,
    required this.avatar,
    required this.kind,
    required this.location,
    required this.profession,
    required this.type,
    required this.useAvatar,
    required this.picture,
  });

  int uid;
  String uuid;
  String? langcode;
  String userName;
  String mail;
  DateTime? created;
  DateTime? changed;
  bool defaultLangcode;
  String contentTranslationSource;
  bool contentTranslationOutdated;
  DateTime? contentTranslationUid;
  bool contentTranslationStatus;
  DateTime? contentTranslationCreated;
  String biography;
  DateTime? birthdate;
  String? cellphone;
  List<String> certifications;
  String company;
  DateTime? dateSavePassword;
  String following;
  List<InterestModel> interests;
  String name;
  String avatar;
  String? kind;
  String? location;
  String profession;
  String type;
  bool useAvatar;
  List<FileModel> picture;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) {
    String createdStr = Model.returnValue(json['created'], "null");
    String changedStr = Model.returnValue(json['changed'], "null");
    String contentTranslationUidStr =
        Model.returnValue(json['content_translation_uid'], "null");
    String contentTranslationCreatedStr =
        Model.returnValue(json['content_translation_created'], "null");
    String birthDateStr = Model.returnValue(json['field_birthdate'], "null");
    String dateSavePasswordStr =
        Model.returnValue(json['field_date_save_password'], 'null');

    return UserModel(
      uid: Model.returnValue(json["uid"], 0),
      uuid: Model.returnValue(json["uuid"], ''),
      langcode: Model.returnValue(json["langcode"], ''),
      userName: Model.returnValue(json["name"], ''),
      mail: Model.returnValue(json["mail"], ''),
      created: DateTime.tryParse(createdStr),
      changed: DateTime.tryParse(changedStr),
      defaultLangcode: Model.returnValue(json["default_langcode"], true),
      contentTranslationSource:
          Model.returnValue(json["content_translation_source"], ''),
      contentTranslationOutdated:
          Model.returnValue(json["content_translation_outdated"], true),
      contentTranslationUid: DateTime.tryParse(contentTranslationUidStr),
      contentTranslationStatus:
          Model.returnValue(json["content_translation_status"], true),
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
      type: Model.returnValue(["field_user_type"], ''),
      useAvatar: Model.returnValue(["field_use_avatar"], true),
      picture: json["user_picture"] == null
          ? []
          : List<FileModel>.from(
              json["user_picture"].map((x) => FileModel.fromMap(x))),
    );
  }

  factory UserModel.empty() => UserModel(
        birthdate: null,
        biography: '',
        cellphone: '',
        changed: null,
        company: '',
        contentTranslationCreated: null,
        contentTranslationOutdated: false,
        contentTranslationSource: '',
        contentTranslationStatus: false,
        contentTranslationUid: null,
        created: null,
        dateSavePassword: null,
        defaultLangcode: false,
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
        picture: [],
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
        "default_langcode": defaultLangcode,
        "content_translation_source": contentTranslationOutdated,
        "content_translation_outdated": contentTranslationOutdated,
        "content_translation_uid": contentTranslationUid != null
            ? contentTranslationUid!.toIso8601String()
            : contentTranslationUid,
        "content_translation_status": contentTranslationStatus,
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
        "user_picture": List<dynamic>.from(picture.map((x) => x.toMap())),
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
