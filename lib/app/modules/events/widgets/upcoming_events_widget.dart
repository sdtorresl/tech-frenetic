import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/core/utils/selectable_item.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/events_store.dart';
import 'package:techfrenetic/app/modules/events/upcomming_events_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/single_event_widget.dart';
import 'package:techfrenetic/app/widgets/forms/date_selector_widget.dart';
import 'package:techfrenetic/app/widgets/forms/dropdown_selector_widget.dart';

import '../../../widgets/highlighted_title_widget.dart';

class UpcommingEventsWidget extends StatefulWidget {
  const UpcommingEventsWidget({super.key});

  @override
  State<UpcommingEventsWidget> createState() => _UpcommingEventsWidgetState();
}

class _UpcommingEventsWidgetState extends State<UpcommingEventsWidget> {
  final _upcommingEventsStore = Modular.get<UpcommingEventsStore>();
  final _eventsStore = Modular.get<EventsStore>();

  double _scrollPosition = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (_upcommingEventsStore.upcommingEvents.isEmpty) {
      _upcommingEventsStore.fetchUpcommingEvents();
    }
    if (_eventsStore.selectableCategories.isEmpty) {
      _eventsStore.fetchCategories();
      _upcommingEventsStore.category = null;
    }

    super.initState();
    _scrollController.addListener(
      () => setState(() {
        if (_scrollController.position.maxScrollExtent > 0) {
          _scrollPosition = _scrollController.position.pixels /
              _scrollController.position.maxScrollExtent;
        } else {
          _scrollPosition = 0;
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchForm(context),
        _upcommingEvents(context),
        _progressBar(),
      ],
    );
  }

  Widget _progressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: LinearProgressIndicator(
        value: _scrollPosition,
      ),
    );
  }

  Widget _upcommingEvents(BuildContext context) {
    return Observer(builder: (builder) {
      switch (_upcommingEventsStore.upcommingEventsState) {
        case StoreState.initial:
        case StoreState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );

        case StoreState.loaded:
          List<EventsModel> _events = _upcommingEventsStore.upcommingEvents;

          if (_events.isNotEmpty) {
            return SizedBox(
              height: 410,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ..._events.map((e) => SingleEventWidget(event: e)).toList(),
                  ],
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Center(
              child: Text(
                context.appLocalizations?.events_no_events ?? '',
                style: context.textTheme.bodyLarge,
              ),
            ),
          );
      }
    });
  }

  Widget _searchForm(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Container(
      color: theme.primaryColorLight,
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.events_upcomming ?? ''),
          const SizedBox(
            height: 25,
          ),
          Text(
            "${context.appLocalizations?.events_search_upcomming ?? ''}:",
            textAlign: TextAlign.left,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _upcommingEventsStore.nameEditingController,
            decoration: InputDecoration(
              label: Text(context.appLocalizations?.name ?? ''),
              hintText: 'Drupalcon',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DateSelectorWidget(
            dateController: _upcommingEventsStore.dateEditingController,
            onDateSelected: _upcommingEventsStore.changeDate,
          ),
          const SizedBox(
            height: 10,
          ),
          Observer(builder: (context) {
            switch (_eventsStore.categoriesState) {
              case StoreState.initial:
                return const SizedBox.shrink();
              case StoreState.loaded:
                if (_eventsStore.selectableCategories.isNotEmpty) {
                  return DropdownSelectorWidget<SelectableItemI>(
                    onChanged: _upcommingEventsStore.changeCategory,
                    labelText: context.appLocalizations?.category ?? '',
                    options: _eventsStore.selectableCategories,
                    selectedValue: _upcommingEventsStore.category,
                  );
                }
                return const SizedBox.shrink();
              case StoreState.loading:
                return const LinearProgressIndicator();
            }
          }),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: _upcommingEventsStore.search,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  context.appLocalizations?.search ?? '',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
