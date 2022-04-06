import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:cross_file/cross_file.dart' show XFile;
import 'package:tus_client/tus_client.dart';

class VideoProvider extends TechFreneticProvider {
  Future<List<VideoModel>> getVideos() async {
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
            videos.add(VideoModel.fromJson(item));
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
    final client = TusClient(
      Uri.parse("https://master.tus.io/files/"),
      file,
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
