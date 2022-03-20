import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class VideoProvider extends TechFreneticProvider {
  Future<List<VideoModel>> getVideos() async {
    List<VideoModel> videos = [];

    try {
      var headers = cloudflareAuth;
      Uri _url = Uri.parse("$cloudflareUrl/$cloudflareAccount/stream");

      var response = await http.get(_url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);

        for (var item in jsonResponse["result"]) {
          videos.add(VideoModel.fromJson(item));
        }
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return videos;
  }
}
