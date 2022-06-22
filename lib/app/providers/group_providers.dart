import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/models/groups_members_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class GroupsProvider extends TechFreneticProvider {
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

  Future<List<GroupModel>> searchGroups() async {
    List<GroupModel> groups = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/group-research");

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
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/group/1/userbelong/json");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

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

  Future<bool?> createGroup(String name, String description, String rules,
      String namePerson, String type) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/en/entity/node?_format=json");

      Map<String, dynamic> body = {
        "type": [
          {"target_id": "group", "target_type": "node_type"}
        ],
        "title": [
          {"value": name}
        ],
        "langcode": [
          {"value": locale}
        ],
        "field_group_featured": [
          {"value": "0"}
        ],
        "field_group_logo": [
          {"target_id": "11", "alt": "Assassins-Creed-Valhalla-1"}
        ],
        "field_group_members": [
          {"value": "tfadmin (1)"}
        ],
        "field_group_rules": [
          {"value": rules}
        ],
        "field_group_articles": [
          {"value": "PlayStation 5: Black"}
        ],
        "field_group_description": [
          {"value": description}
        ]
      };

      Map<String, String> headers = {};
      headers.addAll(jsonHeader);
      headers.addAll(authHeader);
      headers.addAll(basicAuth);
      headers.addAll(sessionHeader);
      headers.addAll(headers);

      var response = await http.post(
        _url,
        body: json.encode(body),
        headers: headers,
      );

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
}
