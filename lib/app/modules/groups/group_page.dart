import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/groups/widgets/join_leave_button_widget.dart';
import 'package:techfrenetic/app/modules/groups/widgets/members_widget.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/post_widget.dart';

import '../../models/group_model.dart';
import '../../widgets/rounded_image_widget.dart';
import 'group_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

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
  final GroupsProvider _groupsProvider = GroupsProvider();
  GroupModel group = GroupModel.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Text(
          AppLocalizations.of(context)!.groups,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: FutureBuilder(
        future: _groupsProvider.getGroup(widget.groupId),
        builder: (BuildContext context, AsyncSnapshot<GroupModel> snapshot) {
          if (snapshot.hasData) {
            group = snapshot.data!;

            return ListView(
              children: [
                _header(context, group),
                _details(context, group),
                _feeds(context, group)
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _header(BuildContext context, GroupModel group) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: RoundedImage(
              url: group.picture,
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  group.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                group.description ?? '',
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: _groupsProvider.getMembers(group.id.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.check),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "${snapshot.data?.length ?? 0} ${AppLocalizations.of(context)!.groups_members}",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: JoinLeaveButtonWidget(
                  group: group,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _details(BuildContext context, GroupModel group) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).unselectedWidgetColor,
            spreadRadius: -5,
            blurRadius: 5,
            offset: const Offset(1.9, 1.7),
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(
          AppLocalizations.of(context)!.groups_details,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _groupType(context, group),
                _members(context, group),
                const SizedBox(
                  height: 15,
                ),
                const Separator(
                  separatorWidth: double.infinity,
                  color: Colors.black38,
                  height: 0.5,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.groups_description,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 10),
                Text(group.description ?? ''),
                const SizedBox(height: 10),
                const Separator(
                  separatorWidth: double.infinity,
                  color: Colors.black38,
                  height: 0.5,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.groups_rules,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 10),
                Text(group.rules ?? ''),
                const SizedBox(height: 10),
                const Separator(
                  separatorWidth: double.infinity,
                  color: Colors.black38,
                  height: 0.5,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _groupType(BuildContext context, GroupModel group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(group.public ? Icons.public : Icons.private_connectivity),
          const SizedBox(
            width: 5,
          ),
          Text(
            group.public
                ? AppLocalizations.of(context)!.groups_public
                : AppLocalizations.of(context)!.groups_private,
          ),
        ],
      ),
    );
  }

  Widget _members(BuildContext context, GroupModel group) {
    return FutureBuilder(
      future: _groupsProvider.getMembers(group.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          List<UserModel> members = snapshot.data!;

          List<Widget> avatars = members
              .map(
                (user) => AvatarWidget(
                  userId: user.uid.toString(),
                  radius: 25,
                ),
              )
              .toList();
          int length = members.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppLocalizations.of(context)!.groups_members.toCapitalize()}($length)",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 5,
                runSpacing: 7,
                children: avatars,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        MembersWidget(members: members)),
                child: Text(AppLocalizations.of(context)!.view_more),
              )
            ],
          );
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }

  Widget _feeds(BuildContext context, GroupModel group) {
    ArticlesProvider _articlesProvideer = ArticlesProvider();

    return FutureBuilder(
      future: _articlesProvideer.getWallByGroup(group),
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlesModel>> snapshot) {
        if (snapshot.hasData) {
          List<ArticlesModel> articles = snapshot.data ?? [];
          List<Widget> postsWidgets = [];

          for (ArticlesModel article in articles) {
            postsWidgets.add(PostWidget(article: article));
          }

          return Column(
            //shrinkWrap: true,
            children: [
              // _postbox(),
              ...postsWidgets,
              const SizedBox(height: 60),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
