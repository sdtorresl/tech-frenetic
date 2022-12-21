import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import 'package:techfrenetic/app/providers/user_provider.dart';

class FollowersProvider extends TechFreneticProvider {
  final UserProvider _userProvider = UserProvider();

  Future<List<UserModel>> getFollowing(int userId) async {
    List<UserModel> following = [];
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/v1/following?user=$userId");
      var response = await http.get(_url, headers: sessionHeader);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = json.jsonDecode(response.body);
        if (decodedResponse.isNotEmpty) {
          String? users = decodedResponse.first['users'];
          List<String> userIds = users
                  ?.split(', ')
                  .where((element) => element.isNotEmpty)
                  .toList() ??
              [];
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

  Future<List<UserModel>> getFollowers(int userId) async {
    List<UserModel> followers = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/en/v1/followers/$userId");

      var response = await http.get(_url, headers: sessionHeader);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = json.jsonDecode(response.body);
        List<String> userIds =
            decodedResponse.map((e) => e["id"] as String).toList();

        for (String id in userIds) {
          UserModel? user = await _userProvider.getUser(id);
          if (user != null) {
            followers.add(user);
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

  Future<bool> addFollower(int userId, int followedUserId) async {
    try {
      List<UserModel> alreadyFollowing = await getFollowing(userId);

      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");

      List<dynamic> following = alreadyFollowing
          .map((u) => {"target_id": u.uid, "target_type": "user"})
          .toList();
      following.add({"target_id": followedUserId, "target_type": "user"});
      Map<String, dynamic> body = {
        "field_following": following.toSet().toList()
      };

      Map<String, String> headers = {}
        ..addAll(jsonHeader)
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> removeFollower(int userId, int followedUserId) async {
    try {
      List<UserModel> alreadyFollowing = await getFollowing(userId);

      Uri _url = Uri.parse("$baseUrl/api/user/$userId?_format=json");
      debugPrint(_url.toString());

      List<dynamic> following = alreadyFollowing
          .where((u) => u.uid != followedUserId)
          .map((u) => {"target_id": u.uid, "target_type": "user"})
          .toList();
      Map<String, dynamic> body = {"field_following": following};

      debugPrint(following.toString());

      Map<String, String> headers = {}
        ..addAll(jsonHeader)
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      var response = await http.patch(
        _url,
        body: json.jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> isFollowing(int userId, int followedUserId) async {
    List<UserModel> alreadyFollowing = await getFollowing(userId);
    bool isFollowing =
        !alreadyFollowing.every((element) => element.uid != followedUserId);
    return isFollowing;
  }
}
