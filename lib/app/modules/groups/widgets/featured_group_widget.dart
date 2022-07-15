import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/utils.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/modules/groups/widgets/join_leave_button_widget.dart';

class FeaturedGroupWidget extends StatefulWidget {
  final GroupModel group;

  const FeaturedGroupWidget({Key? key, required this.group}) : super(key: key);

  @override
  _FeaturedGroupWidgetState createState() => _FeaturedGroupWidgetState();
}

class _FeaturedGroupWidgetState extends State<FeaturedGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
          left: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
          right: BorderSide(
            width: 0.50,
            color: Colors.grey.withOpacity(.6),
          ),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Modular.to.pushNamed("/groups/${widget.group.id}"),
            child: CachedNetworkImage(
              placeholder: (context, value) => const LinearProgressIndicator(),
              errorWidget: (context, value, e) => const Icon(Icons.error),
              imageUrl: widget.group.picture,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parseHtmlString(widget.group.title),
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.group.members!.isNotEmpty ? widget.group.members : 0} - ${AppLocalizations.of(context)!.groups_members}",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 13),
                        ),
                        Text(
                          "${widget.group.posts!.isNotEmpty ? widget.group.posts : 0} - ${AppLocalizations.of(context)!.groups_posts}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                    JoinLeaveButtonWidget(group: widget.group)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}