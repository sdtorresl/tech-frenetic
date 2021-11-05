import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class MyActivity extends StatefulWidget {
  const MyActivity({Key? key}) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1.90,
                  color: Theme.of(context).primaryColor,
                ),
                left: BorderSide(
                  width: 0.50,
                  color: Colors.grey.withOpacity(.6),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).unselectedWidgetColor,
                  spreadRadius: -5,
                  blurRadius: 5,
                  offset: const Offset(1.9, 1.7),
                )
              ],
            ),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HighlightContainer(
                    child: Text(
                      AppLocalizations.of(context)!.my_activity,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).indicatorColor,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
