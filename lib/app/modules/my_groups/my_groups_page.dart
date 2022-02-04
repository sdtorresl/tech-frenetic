import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class MyGroupPage extends StatelessWidget {
  const MyGroupPage({Key? key}) : super(key: key);

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
                      _noGroups(context),
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

  Widget _noGroups(context) {
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
}
