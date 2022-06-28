// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/avatar_widget.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

class MembersWidget extends StatelessWidget {
  const MembersWidget({Key? key, required this.members}) : super(key: key);

  final List<UserModel> members;

  @override
  Widget build(BuildContext context) {
    int length = members.length;

    List<Widget> membersWidgets =
        members.map((member) => _userWidget(context, member)).toList();

    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.groups_members.toCapitalize()}($length)",
                style: Theme.of(context).textTheme.headline1,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: membersWidgets,
            ),
          )
        ]),
      ),
    );
  }

  Widget _userWidget(BuildContext context, UserModel member) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            AvatarWidget(
              userId: member.uid.toString(),
              radius: 50,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.userName,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  member.profession,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Separator(
          separatorWidth: MediaQuery.of(context).size.width,
          color: Colors.black38,
          height: 0.5,
        )
      ],
    );
  }
}
