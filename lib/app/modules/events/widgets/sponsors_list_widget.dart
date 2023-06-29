import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/sponsors_model.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

import '../../../models/dtos/paginator_dto.dart';
import '../../../widgets/paginator_widget.dart';

class SponsorsListWidget extends StatefulWidget {
  final List<SponsorModel> sponsors;
  const SponsorsListWidget({super.key, required this.sponsors});

  @override
  State<SponsorsListWidget> createState() => _SponsorsListWidgetState();
}

class _SponsorsListWidgetState extends State<SponsorsListWidget> {
  late int _currentPage;
  final int _itemsPerPage = 2;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int j = (_itemsPerPage * _currentPage) + _itemsPerPage;
    int maxIndex = j > widget.sponsors.length ? widget.sponsors.length : j;

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
          ...widget.sponsors
              .sublist(_itemsPerPage * _currentPage, maxIndex)
              .map((e) => _sponsorItem(context, e))
              .toList(),
          PaginatorWidget(
            paginator: PaginatorDto(
              totalItems: widget.sponsors.length,
              itemsPerPage: _itemsPerPage,
              totalPages: (widget.sponsors.length / _itemsPerPage).ceil(),
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
    );
  }

  _sponsorItem(BuildContext context, SponsorModel e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Image.network(e.picture),
    );
  }
}
