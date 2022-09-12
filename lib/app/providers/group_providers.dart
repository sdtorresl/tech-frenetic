import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/models/groups_members_model.dart';
import 'package:techfrenetic/app/models/image_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class GroupsProvider extends TechFreneticProvider {
  final UserProvider _userProvider = UserProvider();

  Future<GroupModel> getGroup(int groupId) async {
    GroupModel group = GroupModel.empty();

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/group-id/$groupId");

      debugPrint(_url.toString());

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        group = GroupModel.fromMap(jsonResponse[0]);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return group;
  }

  Future<List<GroupModel>> searchGroups(String groupName) async {
    List<GroupModel> groups = [];

    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/search-group?search=$groupName");

      debugPrint("Getting groups...");
      debugPrint(_url.toString());

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        groups = jsonResponse.map((e) => GroupModel.fromMap(e)).toList();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return groups;
  }

  Future<List<GroupModel>> getRecommended() async {
    List<GroupModel> recommendedGroups = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/groups-recommended");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      debugPrint(_url.toString());
      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        for (var item in jsonResponse) {
          GroupModel group = GroupModel.fromMap(item);
          recommendedGroups.add(group);
        }

        debugPrint(recommendedGroups.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return recommendedGroups;
  }

  Future<List<GroupModel>> getGroupsUserBelongs() async {
    List<GroupModel> recommendedGroups = [];

    try {
      UserModel? loggedUser = await _userProvider.getLoggedUser();
      if (loggedUser != null) {
        Uri _url = Uri.parse(
            "$baseUrl/api/$locale/v1/group/${loggedUser.uid}/userbelong/json");

        Map<String, String> headers = {};
        headers.addAll(authHeader);
        headers.addAll(sessionHeader);

        var response = await http.get(
          _url,
          headers: headers,
        );

        debugPrint(_url.toString());

        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = jsonDecode(response.body);

          for (var item in jsonResponse) {
            GroupModel group = GroupModel.fromMap(item);
            recommendedGroups.add(group);
          }

          debugPrint(recommendedGroups.toString());
        } else {
          debugPrint('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return recommendedGroups;
  }

  Future<bool> createGroup(String name, String description, String rules,
      bool isPublic, ImageModel image) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/entity/group?_format=json");

      Map<String, dynamic> body = {
        "_links": {
          "type": {
            "href":
                "http://dev-techfrenetic.us.seedcloud.co/api/rest/type/group/${isPublic ? "group" : "group_private"}"
          }
        },
        "type": [
          {"target_id": isPublic ? "group" : "group_private"}
        ],
        "label": [
          {"value": name}
        ],
        "field_logo": [
          {"target_id": image.id}
        ],
        "field_description": [
          {"value": description}
        ],
        "field_rules": [
          {"value": rules}
        ]
      };

      Map<String, String> headers = {}
        ..addAll(halHeader)
        ..addAll(authHeader)
        ..addAll(basicAuth)
        ..addAll(sessionHeader);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        debugPrint('Response: ${response.body}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<int?> getUserIdInGroup(int userId, int groupId) async {
    int? gUserId;
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/group-user/$groupId/$userId");

      debugPrint(_url.toString());

      Map<String, String> headers = {}
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.isNotEmpty) {
          gUserId = int.tryParse(jsonResponse[0]["id"]);
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return gUserId;
  }

  Future<bool> joinGroup(int userId, int groupId) async {
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/entity/group_content?_format=hal_json");

      Map<String, dynamic> body = {
        "_links": {
          "type": {
            "href":
                "http://dev-techfrenetic.us.seedcloud.co/api/rest/type/group_content/group-group_membership"
          }
        },
        "type": [
          {"target_id": "group-group_membership"}
        ],
        "gid": [
          {"target_id": groupId}
        ],
        "entity_id": [
          {"target_id": userId}
        ]
      };

      Map<String, String> headers = {}
        ..addAll(halHeader)
        ..addAll(authHeader)
        ..addAll(basicAuth)
        ..addAll(sessionHeader);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );

      debugPrint(_url.toString());
      debugPrint(body.toString());

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> leaveGroup(int gUserId, int groupId) async {
    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/group/$groupId/content/$gUserId?_format=json");

      Map<String, String> headers = {}
        ..addAll(halHeader)
        ..addAll(authHeader)
        ..addAll(basicAuth)
        ..addAll(sessionHeader);

      var response = await http.delete(
        _url,
        headers: headers,
      );

      debugPrint(_url.toString());

      if (response.statusCode == 204) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<List> getGroupsMembers(groupId) async {
    GroupMembersModel members;

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/node/95/?_format=json");

      var response = await http.get(
        _url,
      );

      debugPrint(_url.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse.toString());
        members = GroupMembersModel.fromMap(jsonResponse);
        debugPrint(members.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<UserModel>> getMembers(String groupId) async {
    List<UserModel> members = [];

    try {
      Uri _url =
          Uri.parse("$baseUrl/api/$locale/v1/group/$groupId/members/json");
      debugPrint(_url.toString());
      var response = await http.get(_url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        members = jsonResponse.map((e) => UserModel.fromMap(e)).toList();
        debugPrint(members.toString());
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return members;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> users = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/group-user-list");
      debugPrint(_url.toString());
      var response = await http.get(_url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        users = List<Map<String, dynamic>>.from(jsonResponse["articles"]);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return users;
  }

  Future<bool> createArticleInGroup(
      int groupId, int userId, int articleId) async {
    try {
      Uri _url =
          Uri.parse("$baseUrl/api/entity/group_content?_format=hal_json");
      debugPrint(_url.toString());

      String body = json.encode({
        "_links": {
          "type": {
            "href":
                "http://dev-techfrenetic.us.seedcloud.co/api/rest/type/group_content/group-group_node-article"
          }
        },
        "type": [
          {
            "target_id": "group-group_node-article",
            "target_type": "group_content_type"
          }
        ],
        "uid": [
          {"target_id": userId}
        ],
        "gid": [
          {"target_id": groupId}
        ],
        "entity_id": [
          {"target_id": articleId}
        ]
      });

      Map<String, String> headers = {}
        ..addAll(halHeader)
        ..addAll(authHeader)
        ..addAll(sessionHeader);

      var response = await http.post(_url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }
}
