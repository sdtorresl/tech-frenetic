import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/modules/groups/widgets/join_leave_button_widget.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';

class RecommendedGroupWidget extends StatefulWidget {
  final GroupModel group;

  const RecommendedGroupWidget({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  _RecommendedGroupWidgetState createState() => _RecommendedGroupWidgetState();
}

class _RecommendedGroupWidgetState extends State<RecommendedGroupWidget> {
  final _groupProvider = GroupsProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () => Modular.to.pushNamed("/groups/${widget.group.id}"),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, value) =>
                    const LinearProgressIndicator(),
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
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
          ),
          subtitle: FutureBuilder(
              future: Future.wait([
                _groupProvider.getMembers(widget.group.id.toString()),
                _groupProvider.getPosts(widget.group.id),
              ]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  int members = snapshot.data[0]?.length ?? 0;
                  int posts = snapshot.data[1] ?? 0;
                  return Text(
                    "$members ${AppLocalizations.of(context)!.groups_members} - $posts ${AppLocalizations.of(context)!.groups_posts}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).hintColor, fontSize: 13),
                  );
                }
                return const SizedBox.shrink();
              }),
          trailing: Container(
            constraints: const BoxConstraints(minWidth: 50, maxWidth: 150),
            child: JoinLeaveButtonWidget(group: widget.group),
          ),
        ),
      ),
    );
  }
}
