import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/lesson_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LessonsList extends StatelessWidget {
  LessonsList({super.key, required this.lessons});

  final List<LessonModel> lessons;
  final VideoProvider _videoProvider = Modular.get();

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
                .toList()
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
        ],
      ),
    );
  }
}
