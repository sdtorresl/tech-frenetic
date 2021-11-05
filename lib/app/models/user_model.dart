import 'dart:convert';
import 'package:techfrenetic/app/models/model.dart';

class UserModel extends Model {
  UserModel({
    required this.uid,
    required this.uuid,
    required this.langcode,
    required this.userName,
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
    required this.fieldCertifications,
    required this.company,
    required this.dateSavePassword,
    required this.fieldFollowing,
    required this.fieldInterests,
    required this.name,
    required this.fieldUserAvatar,
    required this.userKind,
    required this.userLocation,
    required this.userProfession,
    required this.userType,
    required this.useAvatar,
    required this.userPicture,
  });

  int uid;
  String uuid;
  String langcode;
  String userName;
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
  String cellphone;
  String fieldCertifications;
  String company;
  DateTime? dateSavePassword;
  String fieldFollowing;
  String fieldInterests;
  String name;
  bool fieldUserAvatar;
  String userKind;
  String userLocation;
  String userProfession;
  String userType;
  bool useAvatar;
  String userPicture;

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

    // DateTime? created = DateTime.tryParse(createdStr);
    // DateTime? changed = DateTime.tryParse(changedStr);
    // DateTime? contentTranslationUid =
    //     DateTime.tryParse(contentTranslationUidStr);
    // DateTime? contentTranslationCreated =
    //     DateTime.tryParse(contentTranslationCreatedStr);
    // DateTime? birthDate = DateTime.tryParse(birthDateStr);

    return UserModel(
      uid: Model.returnValue(json["uid"], 0),
      uuid: Model.returnValue(json["uuid"], ''),
      langcode: Model.returnValue(json["langcode"], ''),
      userName: Model.returnValue(json["name"], ''),
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
      fieldCertifications: Model.returnValue(json["field_certifications"], ''),
      company: Model.returnValue(json["field_company"], ''),
      dateSavePassword: DateTime.tryParse(dateSavePasswordStr),
      fieldFollowing: Model.returnValue(json["field_following"], ''),
      fieldInterests: Model.returnValue(json["field_interests"], ''),
      name: Model.returnValue(json["field_name"], ''),
      fieldUserAvatar: Model.returnValue(json["field_user_avatar"], true),
      userKind: Model.returnValue(json["field_user_kind"], ''),
      userLocation: Model.returnValue(json["field_user_location"], ''),
      userProfession: Model.returnValue(json["field_user_profession"], ''),
      userType: Model.returnValue(["field_user_type"], ''),
      useAvatar: Model.returnValue(["field_use_avatar"], true),
      userPicture: Model.returnValue(json["user_picture"], ''),
    );
  }

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "uuid": uuid,
        "langcode": langcode,
        "name": userName,
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
        "field_certifications": fieldCertifications,
        "field_company": company,
        "field_date_save_password": dateSavePassword != null
            ? dateSavePassword!.toIso8601String()
            : dateSavePassword,
        "field_following": fieldFollowing,
        "field_interests": fieldInterests,
        "field_name": name,
        "field_user_Avatar": fieldUserAvatar,
        "field_user_kind": userKind,
        "field_user_location": userLocation,
        "field_user_profession": userProfession,
        "field_user_type": userType,
        "field_use_avatar": useAvatar,
        "user_picture": userPicture,
      };

  @override
  toString() => toJson();
}
