import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/models/groups_members_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

class GroupsProvider extends TechFreneticProvider {
  Future<GroupModel> getGroup(int id) async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/node/$id/?_format=json");

      Map<String, String> headers = {};
      headers.addAll(authHeader);
      headers.addAll(sessionHeader);

      var response = await http.get(
        _url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return GroupModel(
        title: "Grupo de ejemplo",
        description: "This is a description",
        featured: "featured",
        members: "156",
        picture:
            "https://dev-techfrenetic.us.seedcloud.co/images/temp/image-detail-group.png",
        id: "15",
        posts: "15");
  }

  Future<List<GroupModel>> getRecommended() async {
    List<GroupModel> recommendedGroups = [];

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/groups-recommended");

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

  Future<List<GroupModel>> getGroupsUserBelongs() async {
    List<GroupModel> recommendedGroups = [];

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/group-user-belongs/${prefs.userId}");

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
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 201) {
        debugPrint(response.body);
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
    GroupsMembersModel members;

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/node/95/?_format=json");

      var response = await http.get(
        _url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse.toString());
        members = GroupsMembersModel.fromMap(jsonResponse);
        debugPrint(members.toString());

        // for (var item in jsonResponse) {
        // GroupModel group = GroupModel.fromMap(item);
        //recommendedGroups.add(group);
        // }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
