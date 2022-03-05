import 'dart:convert';
import 'model.dart';

class ImageModel extends Model {
  ImageModel({
    required this.id,
    required this.uuid,
    this.langcode,
    this.type,
    this.filename,
    required this.uri,
    this.filemime,
    this.filesize,
    this.status,
    this.created,
    this.changed,
    this.path,
  });

  int id;
  String uuid;
  String? langcode;
  List<Type>? type;
  String? filename;
  String uri;
  String? filemime;
  int? filesize;
  List<StatusModel>? status;
  List<DateTimeModel>? created;
  List<DateTimeModel>? changed;
  List<PathModel>? path;

  factory ImageModel.fromJson(String str) =>
      ImageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
        id: Model.returnValue(json["fid"], 0),
        uuid: Model.returnValue(json["uuid"], ""),
        langcode: Model.returnValue(json["langcode"], ""),
        type: json["type"] == null
            ? null
            : List<Type>.from(json["type"].map((x) => Type.fromMap(x))),
        filename: Model.returnValue(json["filename"], ""),
        uri: Model.returnValue(json["uri"], ""),
        filemime: Model.returnValue(json["filemime"], ""),
        filesize: Model.returnValue(json["filesize"], 0),
        status: json["status"] == null
            ? null
            : List<StatusModel>.from(
                json["status"].map((x) => StatusModel.fromMap(x))),
        created: json["created"] == null
            ? null
            : List<DateTimeModel>.from(
                json["created"].map((x) => DateTimeModel.fromMap(x))),
        changed: json["changed"] == null
            ? null
            : List<DateTimeModel>.from(
                json["changed"].map((x) => DateTimeModel.fromMap(x))),
        path: json["path"] == null
            ? null
            : List<PathModel>.from(
                json["path"].map((x) => PathModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "langcode": langcode,
        "type": type,
        "filename": filename,
        "uri": uri,
        "filemime": filemime,
        "filesize": filesize,
        "status": status,
        "created": created,
        "changed": changed,
        "path": path,
      };

  factory ImageModel.empty() => ImageModel(id: -1, uri: "", uuid: "");
}

class DateTimeModel {
  DateTimeModel({
    required this.value,
    required this.format,
  });

  DateTime value;
  String format;

  factory DateTimeModel.fromJson(String str) =>
      DateTimeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DateTimeModel.fromMap(Map<String, dynamic> json) => DateTimeModel(
        value: DateTime.parse(json["value"]),
        format: json["format"],
      );

  Map<String, dynamic> toMap() => {
        "value": value.toIso8601String(),
        "format": format,
      };
}

class PathModel {
  PathModel({
    this.alias,
    this.pid,
    this.langcode,
    this.lang,
  });

  dynamic alias;
  dynamic pid;
  String? langcode;
  String? lang;

  factory PathModel.fromJson(String str) => PathModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PathModel.fromMap(Map<String, dynamic> json) => PathModel(
        alias: json["alias"],
        pid: json["pid"],
        langcode: json["langcode"],
        lang: json["lang"],
      );

  Map<String, dynamic> toMap() => {
        "alias": alias,
        "pid": pid,
        "langcode": langcode,
        "lang": lang,
      };
}

class StatusModel {
  StatusModel({
    this.value,
  });

  bool? value;

  factory StatusModel.fromJson(String str) =>
      StatusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusModel.fromMap(Map<String, dynamic> json) => StatusModel(
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "value": value,
      };
}

class Type {
  Type({
    required this.targetId,
  });

  String targetId;

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        targetId: json["target_id"],
      );

  Map<String, dynamic> toMap() => {
        "target_id": targetId,
      };
}
