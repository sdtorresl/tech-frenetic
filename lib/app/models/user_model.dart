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

class PreferencesModel {
  PreferencesModel({
    required this.uid,
    required this.uuid,
    required this.langcode,
    required this.name,
    required this.created,
    required this.changed,
    required this.defaultLangcode,
    required this.contentTranslationSource,
    required this.contentTranslationOutdated,
    required this.contentTranslationUid,
    required this.contentTranslationStatus,
    required this.contentTranslationCreated,
    required this.fieldBiography,
    required this.fieldBirthdate,
    required this.fieldCellphone,
    required this.fieldCertifications,
    required this.fieldCompany,
    required this.fieldDateSavePassword,
    required this.fieldFollowing,
    required this.fieldInterests,
    required this.fieldName,
    required this.fieldUserAvatar,
    required this.fieldUserKind,
    required this.fieldUserLocation,
    required this.fieldUserProfession,
    required this.fieldUserType,
    required this.fieldUseAvatar,
    required this.userPicture,
  });

  String uid;
  String uuid;
  String langcode;

  String name;
  String created;
  String changed;
  String defaultLangcode;
  String contentTranslationSource;
  String contentTranslationOutdated;
  String contentTranslationUid;
  String contentTranslationStatus;
  String contentTranslationCreated;
  String fieldBiography;
  String fieldBirthdate;
  String fieldCellphone;
  String fieldCertifications;
  String fieldCompany;
  String fieldDateSavePassword;
  String fieldFollowing;
  String fieldInterests;
  String fieldName;
  String fieldUserAvatar;
  String fieldUserKind;
  String fieldUserLocation;
  String fieldUserProfession;
  String fieldUserType;
  String fieldUseAvatar;
  String userPicture;

  factory PreferencesModel.fromJson(String str) =>
      PreferencesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreferencesModel.fromMap(Map<String, dynamic> json) =>
      PreferencesModel(
        uid: json["uid"],
        uuid: json["uuid"],
        langcode: json["langcode"],
        name: json["name"],
        created: json["created"],
        changed: json["changed"],
        defaultLangcode: json["default_langcode"],
        contentTranslationSource: json["content_translation_source"],
        contentTranslationOutdated: json["content_translation_outdated"],
        contentTranslationUid: json["content_translation_uid"],
        contentTranslationStatus: json["content_translation_status"],
        contentTranslationCreated: json["content_translation_created"],
        fieldBiography: json["field_biography"],
        fieldBirthdate: json["field_birthdate"],
        fieldCellphone: json["field_cellphone"],
        fieldCertifications: json["field_certifications"],
        fieldCompany: json["field_company"],
        fieldDateSavePassword: json["field_date_save_password"],
        fieldFollowing: json["field_following"],
        fieldInterests: json["field_interests"],
        fieldName: json["field_name"],
        fieldUserAvatar: json["field_user_Avatar"],
        fieldUserKind: json["field_user_kind"],
        fieldUserLocation: json["field_user_location"],
        fieldUserProfession: json["field_user_profession"],
        fieldUserType: json["field_user_type"],
        fieldUseAvatar: json["field_use_avatar"],
        userPicture: json["user_picture"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "uuid": uuid,
        "langcode": langcode,
        "name": name,
        "created": created,
        "changed": changed,
        "default_langcode": defaultLangcode,
        "content_translation_source": contentTranslationOutdated,
        "content_translation_outdated": contentTranslationOutdated,
        "content_translation_uid": contentTranslationUid,
        "content_translation_status": contentTranslationStatus,
        "content_translation_created": contentTranslationCreated,
        "field_biography": fieldBiography,
        "field_birthdate": fieldBirthdate,
        "field_cellphone": fieldCellphone,
        "field_certifications": fieldCertifications,
        "field_company": fieldCompany,
        "field_date_save_password": fieldDateSavePassword,
        "field_following": fieldFollowing,
        "field_interests": fieldInterests,
        "field_name": fieldName,
        "field_user_Avatar": fieldUserAvatar,
        "field_user_kind": fieldUserKind,
        "field_user_location": fieldUserLocation,
        "field_user_profession": fieldUserProfession,
        "field_user_type": fieldUserType,
        "field_use_avatar": fieldUseAvatar,
        "user_picture": userPicture,
      };

  @override
  toString() => toJson();
}
