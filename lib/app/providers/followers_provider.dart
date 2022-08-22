import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/user_provider.dart';

class FollowersProvider extends TechFreneticProvider {
  final UserProvider _userProvider = UserProvider();

  Future<List<UserModel>> getFollowing(String userId) async {
    List<UserModel> following = [];
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/v1/following/?user=$userId");
      debugPrint(_url.toString());

      var response = await http.get(_url, headers: sessionHeader);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = json.jsonDecode(response.body);
        if (decodedResponse.isNotEmpty) {
          List<String> userIds = decodedResponse.first['users'].split(', ');
          for (String id in userIds) {
            UserModel? user = await _userProvider.getUser(id);
            if (user != null) {
              following.add(user);
            }
          }
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return following;
  }

  Future<List<UserModel>> getFollowers(String userId) async {
    List<UserModel> followers = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/en/v1/followers/?user=$userId");
      debugPrint(_url.toString());

      var response = await http.get(_url, headers: sessionHeader);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = json.jsonDecode(response.body);
        if (decodedResponse.isNotEmpty) {
          List<String> userIds = decodedResponse.first['users'].split(', ');
          for (String id in userIds) {
            UserModel? user = await _userProvider.getUser(id);
            if (user != null) {
              followers.add(user);
            }
          }
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return followers;
  }
}
