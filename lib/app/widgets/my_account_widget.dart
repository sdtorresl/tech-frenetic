import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
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
              child: Center(
                child: HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.my_account,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.general_account_settings,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            _form(context),
            _passwordchange(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.subscribtion,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          AppLocalizations.of(context)!
                              .you_dont_have_a_subscribtion_yet,
                          style: Theme.of(context).textTheme.bodyText1),
                    )
                  ],
                ),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.email,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.your_email,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).highlightColor),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.your_country,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.your_country,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).highlightColor),
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.mobile_phone,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.phone_number,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).highlightColor),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.birthdate,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "dd/mm/yyyy",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).highlightColor),
                ),
                onTap: () {/*_selectDate(context);*/},
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => debugPrint("Pressed"),
                    child: Text(
                      AppLocalizations.of(context)!.save_changes,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () => debugPrint("Pressed"),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).indicatorColor,
                            fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorLight),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                                color: Theme.of(context).indicatorColor),
                          ),
                        ),
                      ),
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.password,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(AppLocalizations.of(context)!.last_changed + ': '),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => debugPrint("Pressed"),
                child: Text(
                  AppLocalizations.of(context)!.change_password,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).indicatorColor, fontSize: 15),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Theme.of(context).indicatorColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
