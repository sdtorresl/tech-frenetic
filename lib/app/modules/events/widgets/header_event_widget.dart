import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/events_model.dart';
import 'package:techfrenetic/app/modules/events/widgets/category_widget.dart';

class HeaderEventWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final EventsModel event;
  final bool showCategory;

  const HeaderEventWidget({
    super.key,
    required this.event,
    this.showCategory = false,
    this.backgroundColor = const Color(0xFF0A3991),
    this.foregroundColor = const Color.fromARGB(255, 0, 128, 255),
  });

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
          Row(
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
          ),
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
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => _showMyDialog(context),
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
                  side: const BorderSide(color: Colors.white, width: 1),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
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
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
