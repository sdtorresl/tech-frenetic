import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/providers/countries_provider.dart';
import 'package:techfrenetic/app/providers/genres_provider.dart';
import 'package:techfrenetic/app/providers/professions_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'create_profile_controller.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final CreateProfileController _profileController = Modular.get();
  ProfessionsProvider professions = Modular.get();
  CountriesProvider countries = Modular.get();
  GenresProvider genres = Modular.get();

  final _dateController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  String? defaultValue;
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _dateController.addListener(() {
      if (_dateController.text.isNotEmpty) {
        _profileController
            .changeBirthdate(_dateFormat.parse(_dateController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        onPressed: () {
          List<Widget> actions = [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.cancel.toUpperCase(),
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!
                        .message_btn_later
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Modular.to.pushReplacementNamed("/community");
                  },
                ),
              ],
            ),
          ];
          showMessage(context,
              title: AppLocalizations.of(context)!.message.toUpperCase(),
              content:
                  Text(AppLocalizations.of(context)!.create_profile_message),
              actions: actions);
        },
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.blue_create,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor, fontSize: 30),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.black_create,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 25),
                _createProfileForm(),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: StreamBuilder(
                        stream: _profileController.formValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.hasData
                                ? () => Modular.to
                                    .pushNamed('/create_profile/confirm_number')
                                : null,
                            child: Text(
                              AppLocalizations.of(context)!.continue_button,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: Colors.white),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyName(),
        const SizedBox(height: 25),
        _profession(),
        const SizedBox(height: 25),
        _countries(),
        const SizedBox(height: 25),
        _phone(),
        const SizedBox(height: 25),
        _genre(),
        const SizedBox(height: 25),
        _birthdate(),
        const SizedBox(height: 25),
        _description(),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.meetups_lbl_description,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: _profileController.descriptionStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.tech_passionate,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError
                    ? AppLocalizations.of(context)!.enter_description
                    : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: _profileController.changeDescription,
            );
          },
        ),
      ],
    );
  }

  Widget _phone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.profile_type_phone,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: _profileController.phoneStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    _profileController.changePhone(number.phoneNumber ?? '');
                  },
                  hintText: '5555555',
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                ),
                snapshot.hasError
                    ? Text(
                        TFError.getError(context, snapshot.error as ErrorType),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.red),
                      )
                    : const SizedBox.shrink()
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _countries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.profile_select_country,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: _profileController.countryStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return FutureBuilder(
              future: countries.getCountries(),
              initialData: const <CategoriesModel>[],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<String> countriesNames = [];
                if (snapshot.hasData) {
                  List<CategoriesModel> categoriesModel = snapshot.data;
                  for (var models in categoriesModel) {
                    countriesNames.add(models.category);
                  }

                  return DropdownButton<String>(
                    value: _selectedCountry,
                    isExpanded: true,
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    onChanged: (newValue) {
                      setState(
                        () {
                          _selectedCountry = newValue;
                          _profileController.changeCountry(_selectedCountry!);
                        },
                      );
                    },
                    items: countriesNames
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _profession() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.profile_select_profession,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder<Object>(
            stream: _profileController.professionStream,
            builder: (context, snapshot) {
              return FutureBuilder(
                future: professions.getProfessions(),
                initialData: const <CategoriesModel>[],
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<String> professionsNames = [];
                  if (snapshot.hasData) {
                    List<CategoriesModel> categoriesModel = snapshot.data;
                    for (var models in categoriesModel) {
                      professionsNames.add(models.category);
                    }

                    return DropdownButton<String>(
                      value: defaultValue,
                      isExpanded: true,
                      underline: Container(
                        height: 0.5,
                        color: Colors.black,
                      ),
                      items: professionsNames.map(
                        (String valueItem) {
                          return DropdownMenuItem<String>(
                            child: Text(valueItem),
                            value: valueItem,
                          );
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        setState(
                          () {
                            defaultValue = newValue!;
                            _profileController.changeProfession(newValue);
                            debugPrint(defaultValue);
                          },
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            }),
      ],
    );
  }

  Widget _companyName() {
    return StreamBuilder(
      stream: _profileController.companynameStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.your_company,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).hintColor),
            errorText: snapshot.hasError ? snapshot.error.toString() : null,
            errorStyle: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.red),
          ),
          onChanged: _profileController.changeCompanyName,
        );
      },
    );
  }

  Widget _genre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.profile_select_genre,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: _profileController.genreStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return FutureBuilder(
              future: genres.getGenres(),
              initialData: const <CategoriesModel>[],
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoriesModel>> snapshot) {
                if (snapshot.hasData) {
                  List<CategoriesModel> genres = snapshot.data!;
                  return DropdownButton<String>(
                    value: _profileController.genre,
                    isExpanded: true,
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    items: genres
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(
                            child: Text(e.category),
                            value: e.category,
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        _profileController.changeGenre(newValue);
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _birthdate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.profile_select_birthdate,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: _profileController.birthdateStream,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _dateController,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                hintText: "dd/mm/yyyy",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).highlightColor),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
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
                  if (date != null) {
                    _dateController.text = _dateFormat.format(date);
                  }
                });
              },
            );
          },
        ),
      ],
    );
  }
}
