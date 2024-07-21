import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

import 'highlight_container.dart';

class HighlightedTitleWidget extends StatelessWidget {
  final String text;

  const HighlightedTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    var splittedText = text.split(' ');
    if (splittedText.length == 1) {
      return HighlightContainer(
        child: Text(
          text,
          style: context.textTheme.headline2?.copyWith(
              color: context.theme.colorScheme.primary, fontSize: 26),
        ),
      );
    }

    Color backgroundColor = Theme.of(context).backgroundColor;

    String highlighted = splittedText.first;
    splittedText.removeAt(0);
    String remainingText = splittedText.join(' ');

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: context.textTheme.headline2?.copyWith(
              color: context.theme.colorScheme.primary,
              fontSize: 26,
              backgroundColor: backgroundColor,
            ),
            children: [
              WidgetSpan(
                child: Container(
                  color: backgroundColor,
                  height: 35,
                  width: 5,
                  padding: const EdgeInsets.only(left: 10),
                ),
              ),
              TextSpan(text: highlighted),
              WidgetSpan(
                child: Container(
                  color: backgroundColor,
                  height: 35,
                  width: 5,
                  padding: const EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
          TextSpan(
            text: ' ' + remainingText,
            style: context.textTheme.headline2
                ?.copyWith(color: Colors.black, fontSize: 26),
          ),
        ],
      ),
    );
  }
}
