import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: 1.90,
              color: Theme.of(context).primaryColor,
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
          ],
        ),
        child: ListView(
          children: [
            Card(
              elevation: 0,
              child: Text(
                AppLocalizations.of(context)!.my_account,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).indicatorColor,
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
              ),
            ),
            Text(
              'General Account Settings',
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1.90,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text('Email'),
                        SizedBox(
                          width: 130,
                        ),
                        Text('Your country'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(),
                        ),
                        Expanded(
                          child: TextFormField(),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text('Mobile phone'),
                        SizedBox(
                          width: 80,
                        ),
                        Text('Birthdate'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(),
                        ),
                        Expanded(
                          child: TextFormField(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => debugPrint("Pressed"),
                          child: Text('Save Changes'),
                        ),
                        ElevatedButton(
                          onPressed: () => debugPrint("Pressed"),
                          child: Text('Cancel'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: 1.90,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                    top: BorderSide(
                      width: 1.90,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text('Password'),
                    Row(
                      children: [
                        Text('Last Changed: '),
                        ElevatedButton(
                          onPressed: () => debugPrint("Pressed"),
                          child: Text('Change Password'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text('Subscribtion'),
                Text('You don´t have a subscribtion yet')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
