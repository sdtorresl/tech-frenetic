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

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    _courseHeader(course),
                    LessonsList(classId: id),
                  ]),
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
