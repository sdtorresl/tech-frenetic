import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/my_groups/my_groups.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              child: Text(AppLocalizations.of(context)!.tab_discover,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Tab(
              child: Text(AppLocalizations.of(context)!.tab_groups,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            Tab(
              child: Text(AppLocalizations.of(context)!.tab_create,
                  style: Theme.of(context).textTheme.bodyText2),
            )
          ],
        ),
        body: const TabBarView(
          children: [
            Text('data'),
            MyGroupPage(),
            Text('data'),
          ],
        ),
      ),
    );

    //ListView(
    //
    //       children: [
    //         Padding(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border(
    //                   top: BorderSide(
    //                     width: 1.90,
    //                     color: Theme.of(context).primaryColor,
    //                   ),
    //                   bottom: BorderSide(
    //                     width: 1.00,
    //                     color: Theme.of(context).unselectedWidgetColor,
    //                   ),
    //                   left: BorderSide(
    //                     width: 0.50,
    //                     color: Colors.grey.withOpacity(.6),
    //                   ),
    //                 ),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Theme.of(context).unselectedWidgetColor,
    //                     spreadRadius: -5,
    //                     blurRadius: 5,
    //                     offset: const Offset(1.9, 1.7),
    //                   )
    //                 ]),
    //             child: Column(
    //               children: [
    //                 Container(
    //                   decoration: const BoxDecoration(
    //                     border: Border(
    //                       bottom: BorderSide(width: .5, color: Colors.grey),
    //                     ),
    //                   ),
    //                 ),
    //                 Container(
    //                   padding: const EdgeInsets.symmetric(vertical: 50),
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           HighlightContainer(
    //                             child: Text(
    //                               AppLocalizations.of(context)!.my2,
    //                               style: Theme.of(context)
    //                                   .textTheme
    //                                   .headline1!
    //                                   .copyWith(
    //                                       fontSize: 25,
    //                                       color:
    //                                           Theme.of(context).primaryColor),
    //                             ),
    //                           ),
    //                           Text(
    //                             AppLocalizations.of(context)!.groups,
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .headline1!
    //                                 .copyWith(fontSize: 25),
    //                           ),
    //                         ],
    //                       ),
    //                       const SizedBox(
    //                         height: 50,
    //                       ),
    //                       Text(
    //                         AppLocalizations.of(context)!.no_groups,
    //                         textAlign: TextAlign.center,
    //                         style: Theme.of(context).textTheme.bodyText1!,
    //                       ),
    //                       const SizedBox(
    //                         height: 60,
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: () => {},
    //                         child: Text(
    //                           AppLocalizations.of(context)!.btn_create,
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    // ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
    //       child: Container(
    //         decoration: BoxDecoration(
    //             color: Colors.white,
    //             border: Border(
    //               top: BorderSide(
    //                 width: 1.90,
    //                 color: Theme.of(context).primaryColor,
    //               ),
    //               bottom: BorderSide(
    //                 width: 1.00,
    //                 color: Theme.of(context).unselectedWidgetColor,
    //               ),
    //               left: BorderSide(
    //                 width: 0.50,
    //                 color: Colors.grey.withOpacity(.6),
    //               ),
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Theme.of(context).unselectedWidgetColor,
    //                 spreadRadius: -5,
    //                 blurRadius: 5,
    //                 offset: const Offset(1.9, 1.7),
    //               )
    //             ]),
    //         child: Column(
    //           children: [
    //             Container(
    //               decoration: const BoxDecoration(
    //                 border: Border(
    //                   bottom: BorderSide(width: .5, color: Colors.grey),
    //                 ),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   TextButton(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: Text(
    //                           AppLocalizations.of(context)!.tab_discover,
    //                           style: Theme.of(context).textTheme.bodyText2),
    //                     ),
    //                     onPressed: () => {},
    //                   ),
    //                   TextButton(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: Text(AppLocalizations.of(context)!.tab_groups,
    //                           style: Theme.of(context).textTheme.bodyText2),
    //                     ),
    //                     onPressed: () => {},
    //                   ),
    //                   TextButton(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(5.0),
    //                       child: Text(AppLocalizations.of(context)!.tab_create,
    //                           style: Theme.of(context).textTheme.bodyText2),
    //                     ),
    //                     onPressed: () => {},
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               padding: const EdgeInsets.symmetric(vertical: 50),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       HighlightContainer(
    //                         child: Text(
    //                           AppLocalizations.of(context)!.my2,
    //                           style: Theme.of(context)
    //                               .textTheme
    //                               .headline1!
    //                               .copyWith(
    //                                   fontSize: 25,
    //                                   color: Theme.of(context).primaryColor),
    //                         ),
    //                       ),
    //                       Text(
    //                         AppLocalizations.of(context)!.groups,
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .headline1!
    //                             .copyWith(fontSize: 25),
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 50,
    //                   ),
    //                   Text(
    //                     AppLocalizations.of(context)!.no_groups,
    //                     textAlign: TextAlign.center,
    //                     style: Theme.of(context).textTheme.bodyText1!,
    //                   ),
    //                   const SizedBox(
    //                     height: 60,
    //                   ),
    //                   ElevatedButton(
    //                     onPressed: () => {},
    //                     child: Text(
    //                       AppLocalizations.of(context)!.btn_create,
    //                       style: const TextStyle(
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
