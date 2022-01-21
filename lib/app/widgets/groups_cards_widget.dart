import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/models/group_model.dart';

class GroupsCardsWidget extends StatefulWidget {
  final GroupModel group;

  const GroupsCardsWidget({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  _GroupsCardsWidgetState createState() => _GroupsCardsWidgetState();
}

class _GroupsCardsWidgetState extends State<GroupsCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: ClipOval(
            child: CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: widget.group.picture,
              fit: BoxFit.cover,
              width: 60,
              height: 80,
            ),
          ),
        ),
        title: Text(
          widget.group.title,
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        subtitle: Text(
          "${widget.group.members.isNotEmpty ? widget.group.members : 0} ${AppLocalizations.of(context)!.groups_members} - ${widget.group.posts.isNotEmpty ? widget.group.posts : 0} ${AppLocalizations.of(context)!.groups_posts}",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor, fontSize: 13),
        ),
        trailing: ElevatedButton(
          onPressed: null,
          child: Text(
            AppLocalizations.of(context)!.btn_join,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
