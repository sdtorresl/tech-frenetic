import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

import '../../models/group_model.dart';
import '../../widgets/rounded_image_widget.dart';
import 'group_controller.dart';

class GroupPage extends StatefulWidget {
  final int groupId;

  const GroupPage(
    this.groupId, {
    Key? key,
  }) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends ModularState<GroupPage, GroupController> {
  @override
  Widget build(BuildContext context) {
    GroupsProvider _groupsProvider = GroupsProvider();

    return FutureBuilder(
      future: _groupsProvider.getGroup(widget.groupId),
      builder: (BuildContext context, AsyncSnapshot<GroupModel> snapshot) {
        if (snapshot.hasData) {
          GroupModel group = snapshot.data!;
          return Scaffold(
              appBar: TFAppBar(
                title: Text(
                  group.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              body: ListView(
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            width: 1.90,
                            color: Theme.of(context).primaryColor,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RoundedImage(url: group.picture),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(group.description)
                            ],
                          )
                        ],
                      ))
                ],
              ));
        } else {
          return Scaffold(
            appBar: TFAppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
