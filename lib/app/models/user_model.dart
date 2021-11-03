import 'dart:convert';

class UserModel {
  UserModel({
    required this.uid,
    required this.uuid,
    required this.langcode,
    required this.userName,
    required this.created,
    required this.changed,
    // required this.defaultLangcode,
    // required this.contentTranslationSource,
    // required this.contentTranslationOutdated,
    // required this.contentTranslationUid,
    // required this.contentTranslationStatus,
    // required this.contentTranslationCreated,
    required this.biography,
    required this.birthdate,
    required this.cellphone,
    //required this.fieldCertifications,
    required this.company,
    required this.dateSavePassword,
    //required this.fieldFollowing,
    //required this.fieldInterests,
    required this.name,
    //required this.fieldUserAvatar,
    //required this.fieldUserKind,
    required this.userLocation,
    required this.userProfession,
    required this.userType,
    required this.useAvatar,
    required this.userPicture,
  });

  String uid;
  String uuid;
  String langcode;
  String userName;
  DateTime created;
  DateTime changed;
  // String defaultLangcode;
  // String contentTranslationSource;
  // String contentTranslationOutdated;
  // String contentTranslationUid;
  // String contentTranslationStatus;
  // String contentTranslationCreated;
  String biography;
  DateTime birthdate;
  String cellphone;
  //String fieldCertifications;
  String company;
  DateTime dateSavePassword;
  //String fieldFollowing;
  //String fieldInterests;
  String name;
  //String fieldUserAvatar;
  //String fieldUserKind;
  String userLocation;
  String userProfession;
  String userType;
  bool useAvatar;
  String userPicture;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        uid: json["uid"][0]["value"],
        uuid: json["uuid"][0]["value"],
        langcode: json["langcode"][0]["value"],
        userName: json["name"][0]["value"],
        created: DateTime.parse(json["value"]),
        changed: DateTime.parse(json["value"]),
        // defaultLangcode: json["default_langcode"],
        // contentTranslationSource: json["content_translation_source"],
        // contentTranslationOutdated: json["content_translation_outdated"],
        // contentTranslationUid: json["content_translation_uid"],
        // contentTranslationStatus: json["content_translation_status"],
        // contentTranslationCreated: json["content_translation_created"],
        biography: json["field_biography"][0]["value"],
        birthdate: DateTime.parse(json["value"]),
        cellphone: json["field_cellphone"][0]["value"],
        //fieldCertifications: json["field_certifications"],
        company: json["field_company"][0]["value"],
        dateSavePassword: DateTime.parse(json["value"]),
        //fieldFollowing: json["field_following"],
        //fieldInterests: json["field_interests"],
        name: json["field_name"][0]["value"],
        //fieldUserAvatar: json["field_user_Avatar"],
        //userKind: json["field_user_kind"],
        userLocation: json["field_user_location"][0]["value"],
        userProfession: json["field_user_profession"][0]["value"],
        userType: json["field_user_type"][0]["value"],
        useAvatar: json["field_use_avatar"][0]["value"],
        userPicture: json["user_picture"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "uuid": uuid,
        "langcode": langcode,
        "name": userName,
        "created": created,
        "changed": changed,
        // "default_langcode": defaultLangcode,
        // "content_translation_source": contentTranslationOutdated,
        // "content_translation_outdated": contentTranslationOutdated,
        // "content_translation_uid": contentTranslationUid,
        // "content_translation_status": contentTranslationStatus,
        // "content_translation_created": contentTranslationCreated,
        "field_biography": biography,
        "field_birthdate": birthdate,
        "field_cellphone": cellphone,
        //"field_certifications": fieldCertifications,
        "field_company": company,
        "field_date_save_password": dateSavePassword,
        //"field_following": fieldFollowing,
        //"field_interests": fieldInterests,
        "field_name": name,
        //"field_user_Avatar": fieldUserAvatar,
        //"field_user_kind": userKind,
        "field_user_location": userLocation,
        "field_user_profession": userProfession,
        "field_user_type": userType,
        "field_use_avatar": useAvatar,
        "user_picture": userPicture,
      };

  @override
  toString() => toJson();
}
