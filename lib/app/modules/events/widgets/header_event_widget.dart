import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/widgets/category_widget.dart';

class HeaderEventWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final EventsModel event;
  final bool showCategory;
  final bool showRecent;
  final List<Widget>? actions;

  const HeaderEventWidget(
      {super.key,
      required this.event,
      this.showCategory = false,
      this.showRecent = false,
      this.backgroundColor = const Color(0xFF0A3991),
      this.foregroundColor = const Color.fromARGB(255, 0, 128, 255),
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding:
          const EdgeInsets.only(left: 30.0, right: 30.0, top: 40, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showRecent
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                        width: 19,
                        height: 19,
                        child: Container(
                          color: const Color.fromARGB(255, 245, 249, 255),
                        ),
                      ),
                    ),
                    Text(
                      context.appLocalizations?.events_nearest ?? '',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 15,
          ),
          Text(
            event.eventName,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: foregroundColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
          ),
          showCategory
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CategoryWidget(category: event.category),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Icon(
                color: Colors.white,
                Icons.place_outlined,
                size: 40,
              ),
              const SizedBox(width: 10),
              Text(
                event.location,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                color: Colors.white,
                Icons.calendar_month_outlined,
                size: 40,
              ),
              const SizedBox(width: 20),
              Text(event.startDate.toHumanDate(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      )),
            ],
          ),
          actions != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: actions!,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
