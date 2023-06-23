import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/speaker_model.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

class SpeakersListWidget extends StatelessWidget {
  final List<SpeakerModel> speakers;
  const SpeakersListWidget({super.key, required this.speakers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.events_speakers ?? ''),
          const SizedBox(
            height: 15,
          ),
          ...speakers.map((e) => _speakerView(context, e)).toList()
        ],
      ),
    );
  }

  _speakerView(BuildContext context, e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(e.picture),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5),
            child: Text(
              e.name,
              style: context.textTheme.headline2?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                const Icon(
                  Icons.square,
                  color: Color(0xff00336a),
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  e.location,
                  style: context.textTheme.headline4?.copyWith(
                    color: const Color(0xff00336a),
                  ),
                ),
              ],
            ),
          ),
          Text(e.description),
        ],
      ),
    );
  }
}
