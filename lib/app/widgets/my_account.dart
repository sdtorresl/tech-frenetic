import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  DateTime selectedDate = DateTime.now();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: Text(
                  AppLocalizations.of(context)!.my_account,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor,
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'General Account Settings',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            _form(context),
            _passwordchange(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: const [
                  Text('Subscribtion'),
                  Text('You don´t have a subscribtion yet')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: .9,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              Column(
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
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "your email",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).highlightColor),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Your country",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).highlightColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "phone number",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context).highlightColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "dd/mm/yyyy",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context).highlightColor),
                            ),
                            onTap: () {/*_selectDate(context);*/},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 106.5),
                  ElevatedButton(
                    onPressed: () => debugPrint("Pressed"),
                    child: const Text('Save Changes'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () => debugPrint("Pressed"),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _selectDate(BuildContext context) async{
  //    DateTime selected = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2030),
  //     );
  //   if (selected != null && selected!= selectedDate )
  //   setState(() {
  //     selectedDate = selected;
  //   });
  // }
  Widget _passwordchange(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: .9,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            top: BorderSide(
              width: .9,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              const Text('Password'),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Last Changed: ' ''),
                  ),
                  ElevatedButton(
                    onPressed: () => debugPrint("Pressed"),
                    child: const Text('Change Password'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
