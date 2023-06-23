import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/sponsors_model.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

class SponsorsListWidget extends StatelessWidget {
  final List<SponsorModel> sponsors;
  const SponsorsListWidget({super.key, required this.sponsors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.events_sponsors ?? ''),
          const SizedBox(
            height: 15,
          ),
          ...sponsors.map((e) => _sponsorItem(context, e)).toList()
        ],
      ),
    );
  }

  _sponsorItem(BuildContext context, SponsorModel e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Image.network(e.picture),
    );
  }
}
