import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  _GroupsWidgetState createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 1.90,
                    color: Theme.of(context).primaryColor,
                  ),
                  bottom: BorderSide(
                    width: 1.00,
                    color: Theme.of(context).unselectedWidgetColor,
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
                ]),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: .5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Discover groups',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        onPressed: () => {},
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('My groups',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        onPressed: () => {},
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Create group',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HighlightContainer(
                            child: Text(
                              'My',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Text(
                            'groups',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'You have no groups yet',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text(
                          'Create a group',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
