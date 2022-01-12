import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/my_account/my_account_controller.dart';
import 'package:techfrenetic/app/providers/countries_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

CountriesProvider countries = CountriesProvider();

class _MyAccountPageState
    extends ModularState<MyAccountPage, MyAccountController> {
  final prefs = UserPreferences();

  DateTime? datePicked;

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
  DateTime? birthdate;
  String? cellphone;
  String? defaultCountry;
  bool _isLoading = false;
  final emailController = TextEditingController();
  final cellphoneController = TextEditingController();

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
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: prefs.userEmail,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).highlightColor),
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.red),
                        ),
                        onChanged: (text) {
                          email = text;
                          store.changeEmail(email!);
                        });
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
                  return FutureBuilder(
                    future: countries.getCountries(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<String> countriesNames = [];
                      if (snapshot.hasData) {
                        List<CategoriesModel> categoriesModel = snapshot.data;
                        for (var models in categoriesModel) {
                          countriesNames.add(models.category);
                        }
                        String? defaultValue = countriesNames.first;
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
                          items: countriesNames
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        );
                      } else {
                        return Text(
                          'Loading categories...',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        );
                      }
                    },
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
                    controller: cellphoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phone_number,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).highlightColor),
                      errorText: snapshot.hasError
                          ? 'Ingrese un numero de telefono'
                          : null,
                      errorStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.red),
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
                    readOnly: true,
                    showCursor: true,
                    decoration: InputDecoration(
                      hintText: datePicked == null
                          ? "dd/mm/yyyy"
                          : DateFormat('dd/MMM/yyyy').format(datePicked!),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).highlightColor),
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      errorStyle: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.red),
                    ),

                    onTap: () async {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then((date) {
                        setState(() {
                          datePicked = date;
                          store.changeBirthdate(date!);
                        });
                      });
                    },
                    // onChanged: (text) {
                    //   store.changeBirthdate(datePicked!);
                    // }
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
                    child: cancelUpdate(),
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
              changePasswordButton(),
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
          onPressed: !_isLoading
              ? () async {
                  debugPrint(snapshot.data.toString());
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
                    Widget content = Text(AppLocalizations.of(context)!
                        .error_sorry_unrecognized_username_or_password);
                    List<Widget> actions = [
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.close.toUpperCase(),
                          style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ];
                    showMessage(context,
                        title: AppLocalizations.of(context)!.error,
                        content: content,
                        actions: actions);
                    debugPrint('not updated');
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
      },
    );
  }

  Widget cancelUpdate() {
    return ElevatedButton(
      onPressed: () {
        emailController.clear();
        cellphoneController.clear();
        setState(() {
          datePicked = null;
          defaultCountry = null;
        });
        return debugPrint('hola');
      },
      child: Text(
        AppLocalizations.of(context)!.cancel,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Theme.of(context).indicatorColor, fontSize: 15),
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorLight),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Theme.of(context).indicatorColor),
          ),
        ),
      ),
    );
  }

  Widget changePasswordButton() {
    return ElevatedButton(
      onPressed: () => debugPrint("Pressed"),
      child: Text(
        AppLocalizations.of(context)!.change_password,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Theme.of(context).indicatorColor, fontSize: 15),
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColorLight),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Theme.of(context).indicatorColor),
          ),
        ),
      ),
    );
  }
}
