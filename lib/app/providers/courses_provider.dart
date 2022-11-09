import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/dto/paginator.dart';
import 'package:techfrenetic/app/models/courses_model.dart';
import 'package:techfrenetic/app/models/lesson_model.dart';
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
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/internal-course/$id");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        course = CourseModel.fromJson(jsonResponse.first);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return course;
  }

  Future<Paginator<LessonModel>> getVideosByCourse(int id,
      {int page = 0}) async {
    Paginator<LessonModel> paginator = Paginator(
        currentPage: page, itemsPerPage: 0, totalItems: 0, totalPages: 0);

    try {
      Uri _url = Uri.parse(
          "$baseUrl/api/$locale/v1/internal-course-videos/$id?page=$page");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        paginator = Paginator.fromMap(jsonResponse, LessonModel.fromMap);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return paginator;
  }
}
