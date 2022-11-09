import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';
import 'package:techfrenetic/app/models/lesson_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/paginator_widget.dart';

class LessonsList extends StatefulWidget {
  const LessonsList({super.key, required this.classId});

  final int classId;

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  final VideoProvider _videoProvider = Modular.get();
  final CoursesProvider _coursesProvider = Modular.get();

  PaginatorDto<LessonModel> paginator = PaginatorDto(
      totalItems: 0, itemsPerPage: 0, totalPages: 0, currentPage: 0);
  List<LessonModel> lessons = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 15),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)?.courses_lessons_intro ?? "",
              style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 22),
            ),
            FutureBuilder(
              future: _coursesProvider.getVideosByCourse(widget.classId,
                  page: _currentPage),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  paginator = snapshot.data;
                  lessons = paginator.items;

                  return Column(
                    children: [
                      ...lessons
                          .map(
                            (lesson) => FutureBuilder(
                              future: _videoProvider.getVideo(lesson.videoId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<VideoModel?> snapshot) {
                                if (snapshot.hasData) {
                                  VideoModel? video = snapshot.data;
                                  return video != null
                                      ? _thumbnail(video, lesson, context)
                                      : const SizedBox.shrink();
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          )
                          .toList(),
                      PaginatorWidget(
                        paginator: paginator,
                        onPageChange: (int index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ));
  }

  Widget _thumbnail(
      VideoModel video, LessonModel lesson, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CachedNetworkImage(
                    imageUrl: video.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: const Color.fromRGBO(50, 50, 50, 0.1),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill_sharp,
                        color: Colors.white,
                        size: 75,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            lesson.title,
            style: Theme.of(context).textTheme.headline2,
          ),
          lesson.description != null
              ? Text(
                  lesson.description!,
                  style: Theme.of(context).textTheme.headline2,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
