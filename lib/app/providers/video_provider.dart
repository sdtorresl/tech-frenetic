import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:cross_file/cross_file.dart' show XFile;
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:tus_client/tus_client.dart';

class VideoProvider extends TechFreneticProvider {
  Future<List<VideoModel>> getVideos({int? userId}) async {
    List<VideoModel> videos = [];

    try {
      var headers = cloudflareAuth;
      Uri _url = Uri.parse(
          "$cloudflareUrl/$cloudflareAccount/stream?limit=50&status=ready");

      debugPrint(_url.toString());

      var response = await http.get(_url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);

        for (var item in jsonResponse["result"]) {
          try {
            var videoModel = VideoModel.fromJson(item);
            if (userId != null) {
              if (videoModel.meta?.userId == userId) {
                videos.add(videoModel);
              }
            } else {
              videos.add(videoModel);
            }
          } catch (e) {
            debugPrint("Exception getting video model");
            debugPrint(item);
            debugPrint(e.toString());
          }
        }
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return videos;
  }

  uploadVideo(XFile file, void Function()? onComplete,
      Function(double)? onProgress) async {
    UserProvider _userProvider = UserProvider();
    UserModel? loggedUSer = await _userProvider.getLoggedUser();

    final client = TusClient(
      Uri.parse("$cloudflareUrl/$cloudflareAccount/stream"),
      file,
      headers: cloudflareAuth,
      metadata: {
        'author': loggedUSer != null ? loggedUSer.userName : '',
        'userId': loggedUSer != null ? loggedUSer.uid.toString() : '',
        'userAvatar': prefs.userAvatar ?? ''
      },
      maxChunkSize: 5 * 1024 * 1024,
      store: TusMemoryStore(),
    );

    await client.upload(
      onComplete: () {
        debugPrint("Complete!");

        // Prints the uploaded file URL
        debugPrint(client.uploadUrl.toString());

        if (onComplete != null) {
          onComplete();
        }
      },
      onProgress: onProgress,
    );
  }
}
