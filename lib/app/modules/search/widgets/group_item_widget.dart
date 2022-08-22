import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/group_model.dart';

class GroupItemWidget extends StatefulWidget {
  final GroupModel group;

  const GroupItemWidget({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  _GroupItemWidgetState createState() => _GroupItemWidgetState();
}

class _GroupItemWidgetState extends State<GroupItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Modular.to.pushNamed("/groups/${widget.group.id}"),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
          softWrap: true,
        ),
        subtitle: Text(
          "${widget.group.description}",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor, fontSize: 13),
          softWrap: true,
        ),
      ),
    );
  }
}
