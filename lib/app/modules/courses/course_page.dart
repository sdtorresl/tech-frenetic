import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/courses_model.dart';
import 'package:techfrenetic/app/modules/courses/widgets/course_card.dart';
import 'package:techfrenetic/app/modules/courses/widgets/lessons_list.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class CoursePage extends StatelessWidget {
  CoursePage({super.key, required this.id});

  final int id;
  final CoursesProvider _coursesProvider = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: FutureBuilder(
        future: _coursesProvider.getCourse(id),
        builder: (BuildContext context, AsyncSnapshot<CourseModel?> snapshot) {
          if (snapshot.hasData) {
            CourseModel course = snapshot.data!;
            /* course.lessons = [
              LessonModel("2d02e4b8f69c7b7b19641ecaddca1c00",
                  "Ejemplo de video con titulo extra extra largo"),
              LessonModel(
                  "a3389294282d228175dc33badc1ee579", "Ejemplo de video"),
              LessonModel(
                  "03d78483408e740ee0a8920ef82ecf3b", "Ejemplo de video"),
              LessonModel(
                  "0e6e31d3f649531234dd6352582264fe", "Ejemplo de video"),
              LessonModel(
                  "2d02e4b8f69c7b7b19641ecaddca1c00", "Ejemplo de video"),
            ]; */

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                      [_courseHeader(course), LessonsList(classId: id)]),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _courseHeader(CourseModel course) {
    return Container(
      padding: const EdgeInsets.only(top: 0, right: 35, left: 35, bottom: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseCard(imageUrl: course.picture, headline: course.title),
          const SizedBox(height: 20),
          Text(course.description),
          const SizedBox(height: 15),
          course.owner != null
              ? Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(course.owner ?? '')
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
