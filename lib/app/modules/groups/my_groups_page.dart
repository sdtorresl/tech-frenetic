import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:techfrenetic/app/widgets/group_card_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class MyGroupPage extends StatefulWidget {
  const MyGroupPage({Key? key}) : super(key: key);

  @override
  State<MyGroupPage> createState() => _MyGroupPageState();
}

class _MyGroupPageState extends State<MyGroupPage> {
  String searchText = "";
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
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
                              AppLocalizations.of(context)!.my2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.groups,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 25),
                          ),
                        ],
                      ),
                      _userGroups(context)
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

  Widget _noGroups(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          AppLocalizations.of(context)!.no_groups,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset('assets/img/groups/create.png'),
        ),
        ElevatedButton(
          onPressed: () =>
              Modular.to.pushNamed("/community/groups/create_groups"),
          child: Text(
            AppLocalizations.of(context)!.btn_create,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _userGroups(BuildContext context) {
    GroupsProvider groupsProvider = GroupsProvider();

    return FutureBuilder(
      future: groupsProvider.getGroupsUserBelongs(),
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasData) {
          List<GroupModel> groups = snapshot.data!;

          return Column(children: [
            const SizedBox(
              height: 20,
            ),
            _searchBox(context),
            const SizedBox(
              height: 20,
            ),
            ..._groupsWidget(groups)
          ]);
        } else {
          return _noGroups(context);
        }
      },
    );
  }

  Widget _searchBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 2, color: Colors.black45),
          bottom: BorderSide(width: 2, color: Colors.black45),
          left: BorderSide(width: 2, color: Colors.black45),
          right: BorderSide(width: 2, color: Colors.black45),
        ),
      ),
      child: TextFormField(
        controller: searchTextController,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          suffixIcon: IconButton(
            icon: Icon(Icons.cancel,
                color: Theme.of(context).unselectedWidgetColor),
            onPressed: () {
              searchTextController.clear();
              setState(() {
                searchText = "";
              });
            },
          ),
          hintText: AppLocalizations.of(context)!.search_text,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).primaryColor),
          fillColor: Colors.white,
          filled: true,
        ),
        onChanged: (text) {
          setState(() {
            searchText = text;
          });
        },
        onFieldSubmitted: (text) {
          debugPrint("Submitted $text");
        },
      ),
    );
  }

  _groupsWidget(List<GroupModel> groups) {
    return groups.map(
      (group) {
        if (group.title.toLowerCase().contains(searchText)) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: GroupCardWidget(group: group),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ).toList();
  }
}
