import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/dtos/paginator_dto.dart';
import 'package:techfrenetic/app/models/speaker_model.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';
import 'package:techfrenetic/app/widgets/paginator_widget.dart';

class SpeakersListWidget extends StatefulWidget {
  final List<SpeakerModel> speakers;
  const SpeakersListWidget({super.key, required this.speakers});

  @override
  State<SpeakersListWidget> createState() => _SpeakersListWidgetState();
}

class _SpeakersListWidgetState extends State<SpeakersListWidget> {
  late int _currentPage;
  final int _itemsPerPage = 1;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int j = (_itemsPerPage * _currentPage) + _itemsPerPage;
    int maxIndex = j > widget.speakers.length ? widget.speakers.length : j;

    return Container(
      color: const Color.fromARGB(255, 237, 244, 255),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HighlightedTitleWidget(
                text: context.appLocalizations?.events_speakers ?? ''),
            const SizedBox(
              height: 15,
            ),
            ...widget.speakers
                .sublist(_itemsPerPage * _currentPage, maxIndex)
                .map((e) => _speakerView(context, e))
                .toList(),
            PaginatorWidget(
              paginator: PaginatorDto(
                totalItems: widget.speakers.length,
                itemsPerPage: _itemsPerPage,
                totalPages: (widget.speakers.length / _itemsPerPage).ceil(),
                currentPage: _currentPage,
              ),
              onPageChange: (i) {
                setState(() {
                  _currentPage = i;
                });
              },
            )
          ],
        ),
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
              e.title,
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
