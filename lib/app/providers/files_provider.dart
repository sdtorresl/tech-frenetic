import 'dart:convert' as json;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/image_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class FilesProvider extends TechFreneticProvider {
  Future<ImageModel?> uploadFile(File file) async {
    Uri _url = Uri.parse("$baseUrl/api/entity/file?_format=hal_json");

    final bytes = await file.readAsBytes();
    String base64File = json.base64Encode(bytes);

    Map<String, String> headers = {};
    headers.addAll(basicAuth);
    headers.addAll(halHeader);
    headers.addAll(authHeader);

    ImageModel? image;

    try {
      String body = json.jsonEncode({
        "_links": {
          "type": {
            "href":
                "http://dev-techfrenetic.us.seedcloud.co/api/rest/type/file/image"
          }
        },
        "uri": [
          {"value": "public://article"}
        ],
        "filename": [
          {"value": "article.png"}
        ],
        "filemime": [
          {"value": "image/png"}
        ],
        "type": [
          {"target_id": "image"}
        ],
        "data": [
          {"value": base64File}
        ]
      });
      debugPrint(_url.toString());
      var response = await http.post(_url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        image = ImageModel.fromJson(response.body);
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint(response.reasonPhrase);
        debugPrint(response.body);
      }
    } catch (error) {
      debugPrint("Exception uploading image: $error");
    }

    return image;
  }
}
