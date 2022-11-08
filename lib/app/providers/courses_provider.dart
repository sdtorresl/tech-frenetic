import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/courses_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class CoursesProvider extends TechFreneticProvider {
  Future<List<CourseModel>> getCourses() async {
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/courses");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        List<CourseModel> courses = List<CourseModel>.from(
            jsonResponse["articles"].map((x) => CourseModel.fromJson(x)));

        return courses;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<CourseModel?> getCourse(int id) async {
    CourseModel? course;

    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/courses");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        List<CourseModel> courses = List<CourseModel>.from(
            jsonResponse["articles"].map((x) => CourseModel.fromJson(x)));
        // TODO: Update method

        return courses.first;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return course;
  }
}
