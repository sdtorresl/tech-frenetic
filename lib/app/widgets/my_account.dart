import 'package:flutter/material.dart';
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
                AppLocalizations.of(context)!.general_account_settings,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            _form(context),
            _passwordchange(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.subscribtion),
                  Text(AppLocalizations.of(context)!
                      .you_dont_have_a_subscribtion_yet)
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
                    children: [
                      Text(AppLocalizations.of(context)!.email),
                      const SizedBox(
                        width: 130,
                      ),
                      Text(AppLocalizations.of(context)!.your_country),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.your_email,
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
                            hintText:
                                AppLocalizations.of(context)!.your_country,
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
                      children: [
                        Text(AppLocalizations.of(context)!.mobile_phone),
                        const SizedBox(
                          width: 80,
                        ),
                        Text(AppLocalizations.of(context)!.birthdate),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.phone_number,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => debugPrint("Pressed"),
                    child: Text(AppLocalizations.of(context)!.save_changes),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () => debugPrint("Pressed"),
                      child: Text(AppLocalizations.of(context)!.cancel),
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
              Text(AppLocalizations.of(context)!.password),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                        Text(AppLocalizations.of(context)!.last_changed + ': '),
                  ),
                  ElevatedButton(
                    onPressed: () => debugPrint("Pressed"),
                    child: Text(AppLocalizations.of(context)!.change_password),
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
