import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/modules/my_account/my_account_controller.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState
    extends ModularState<MyAccountPage, MyAccountController> {
  final prefs = UserPreferences();

  DateTime _date = DateTime.now();

  List<String> items = [
    'Country 1',
    'Country 2',
    'Country 3',
    'Country 4',
    'Country 5',
    'Country 6',
    'Country 7',
    'Country 8',
    'Country 9',
    'Country 10',
    'Country 11',
    'Country 12',
  ];
  // DateTime? birthdate;
  // String? cellphone;
  String? defaultCountry;
  bool _isLoading = false;

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
    String? email = prefs.userEmail;
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
              StreamBuilder(
                  stream: store.emailStream,
                  builder: (context, snapshot) {
                    store.changeEmail(email!);
                    return TextFormField(
                      decoration: InputDecoration(
                        hintText: prefs.userEmail,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).highlightColor),
                      ),
                      onChanged: store.changeEmail,
                    );
                  }),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.your_country,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              StreamBuilder(
                stream: store.countryStream,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return DropdownButton<String>(
                    value: defaultCountry,
                    isExpanded: true,
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          defaultCountry = newValue;
                          store.changeCountry(defaultCountry!);
                        },
                      );
                    },
                    hint: Text(
                      AppLocalizations.of(context)!.your_country,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).hintColor),
                    ),
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.mobile_phone,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              StreamBuilder(
                stream: store.cellphoneStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phone_number,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).highlightColor),
                    ),
                    onChanged: store.changeCellphone,
                  );
                },
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.birthdate,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              StreamBuilder(
                stream: store.birthdateStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    decoration: InputDecoration(
                      hintText: "dd/mm/yyyy",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).highlightColor),
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _date = picked;
                          debugPrint(_date.toString());
                        });
                      }
                    },
                    onChanged: store.changeBirthdate(_date),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  updateButton(),
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

  Widget updateButton() {
    return StreamBuilder<Object>(
        stream: store.formValidStream,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: snapshot.hasData && !_isLoading
                ? () async {
                    setState(() {
                      _isLoading = true;
                    });
                    bool article = await store.update();
                    setState(() {
                      _isLoading = true;
                    });
                    if (article == true) {
                      Modular.to.popAndPushNamed("/community");
                    } else {
                      debugPrint('Article not post');
                    }
                  }
                : null,
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
          );
        });
  }
}
