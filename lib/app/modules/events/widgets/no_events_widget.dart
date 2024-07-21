import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

class NoEventsWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  const NoEventsWidget({
    super.key,
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Text(context.appLocalizations?.events_no_events ?? ''),
      ),
    );
  }
}
