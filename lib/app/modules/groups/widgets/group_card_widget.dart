import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupCardWidget extends StatelessWidget {
  const GroupCardWidget({Key? key, required this.group}) : super(key: key);

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Routing to group page ${group.id}...");
        Modular.to.pushNamed("/groups/${group.id}");
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: group.picture,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 15,
                  bottom: 15,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                    ),
                    child: Row(
                      children: [
                        Icon(group.public
                            ? Icons.public
                            : Icons.private_connectivity),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(group.public
                            ? AppLocalizations.of(context)!.groups_public
                            : AppLocalizations.of(context)!.groups_private),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(group.members ?? "0"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
