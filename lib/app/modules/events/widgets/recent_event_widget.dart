import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/events/recent_event_store.dart';
import 'package:techfrenetic/app/modules/events/widgets/header_event_widget.dart';

class RecentEventWidget extends StatelessWidget {
  const RecentEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RecentEventStore store = Modular.get();

    return Observer(builder: (_) {
      switch (store.state) {
        case RecentEventStoreState.initial:
        case RecentEventStoreState.loading:
          return Container(
            color: const Color(0xFF0A3991),
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        case RecentEventStoreState.loaded:
          if (store.event != null) {
            return HeaderEventWidget(
              event: store.event!,
              showRecent: true,
              actions: [
                OutlinedButton(
                  onPressed: () =>
                      Modular.to.pushNamed("/events/${store.event?.slug}"),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      context.appLocalizations?.events_learn_more ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                OutlinedButton(
                  onPressed: () =>
                      Modular.to.pushNamed("/events/${store.event?.slug}"),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      context.appLocalizations?.events_buy ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 1),
                  ),
                )
              ],
            );
            //return _lastEvent(store.event!, context);
          }
          return const SizedBox.shrink();
        case RecentEventStoreState.error:
          return Text(context.appLocalizations?.error ?? '');
      }
    });
  }
}
