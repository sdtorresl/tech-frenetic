// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

class VideoModel {
  VideoModel({
    required this.uid,
    required this.thumbnail,
    this.thumbnailTimestampPct,
    required this.readyToStream,
    required this.status,
    this.meta,
    required this.created,
    required this.modified,
    required this.size,
    this.preview,
    this.allowedOrigins,
    this.requireSignedUrLs,
    required this.uploaded,
    this.uploadExpiry,
    this.maxSizeBytes,
    this.maxDurationSeconds,
    //this.duration,
    this.input,
    this.playback,
    this.watermark,
  });

  String uid;
  String thumbnail;
  int? thumbnailTimestampPct;
  bool readyToStream;
  Status status;
  Meta? meta;
  DateTime created;
  DateTime modified;
  int size;
  String? preview;
  List<dynamic>? allowedOrigins;
  bool? requireSignedUrLs;
  DateTime uploaded;
  dynamic uploadExpiry;
  dynamic maxSizeBytes;
  dynamic maxDurationSeconds;
  //double? duration;
  Input? input;
  Playback? playback;
  dynamic watermark;

  factory VideoModel.fromRawJson(String str) =>
      VideoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        uid: json["uid"],
        thumbnail: json["thumbnail"],
        thumbnailTimestampPct: json["thumbnailTimestampPct"],
        readyToStream: json["readyToStream"],
        status: Status.fromJson(json["status"]),
        meta: Meta.fromJson(json["meta"]),
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        size: json["size"],
        preview: json["preview"],
        allowedOrigins:
            List<dynamic>.from(json["allowedOrigins"].map((x) => x)),
        requireSignedUrLs: json["requireSignedURLs"],
        uploaded: DateTime.parse(json["uploaded"]),
        uploadExpiry: json["uploadExpiry"],
        maxSizeBytes: json["maxSizeBytes"],
        maxDurationSeconds: json["maxDurationSeconds"],
        //duration: double.tryParse(json["duration"]),
        input: Input.fromJson(json["input"]),
        playback: Playback.fromJson(json["playback"]),
        watermark: json["watermark"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "thumbnail": thumbnail,
        "thumbnailTimestampPct": thumbnailTimestampPct,
        "readyToStream": readyToStream,
        "status": status.toJson(),
        "meta": meta != null ? meta!.toJson() : meta,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
        "size": size,
        "preview": preview,
        "allowedOrigins": allowedOrigins != null
            ? List<dynamic>.from(allowedOrigins!.map((x) => x))
            : allowedOrigins,
        "requireSignedURLs": requireSignedUrLs,
        "uploaded": uploaded.toIso8601String(),
        "uploadExpiry": uploadExpiry,
        "maxSizeBytes": maxSizeBytes,
        "maxDurationSeconds": maxDurationSeconds,
        //"duration": duration,
        "input": input != null ? input!.toJson() : input,
        "playback": playback != null ? playback!.toJson() : playback,
        "watermark": watermark,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

class Meta {
  Meta({
    this.author,
    this.downloadedFrom,
    this.name,
    this.userId,
  });

  String? author;
  String? downloadedFrom;
  String? name;
  int? userId;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        author: json["author"],
        downloadedFrom: json["downloaded-from"],
        name: json["name"],
        userId: int.tryParse(json["userId"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "downloaded-from": downloadedFrom,
        "name": name,
        "userId": userId
      };
}

class Input {
  Input({
    required this.width,
    required this.height,
  });

  int width;
  int height;

  factory Input.fromRawJson(String str) => Input.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
      };
}

class Playback {
  Playback({
    required this.hls,
    required this.dash,
  });

  String hls;
  String dash;

  factory Playback.fromRawJson(String str) =>
      Playback.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Playback.fromJson(Map<String, dynamic> json) => Playback(
        hls: json["hls"],
        dash: json["dash"],
      );

  Map<String, dynamic> toJson() => {
        "hls": hls,
        "dash": dash,
      };
}

class Status {
  Status({
    this.state,
    this.pctComplete,
    this.errorReasonCode,
    this.errorReasonText,
  });

  String? state;
  String? pctComplete;
  String? errorReasonCode;
  String? errorReasonText;

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        state: json["state"],
        pctComplete: json["pctComplete"],
        errorReasonCode: json["errorReasonCode"],
        errorReasonText: json["errorReasonText"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "pctComplete": pctComplete,
        "errorReasonCode": errorReasonCode,
        "errorReasonText": errorReasonText,
      };
}
