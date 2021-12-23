import 'package:flutter/material.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/create_profile/create_profile_controller.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState
    extends ModularState<CreateProfilePage, CreateProfileController> {
  bool _isLoading = false;
  List<String> itemsProfession = [
    'Profession 1',
    'Profession 2',
    'Profession 3',
    'Profession 4',
  ];
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
  String? defaultProfession;
  String? defaultCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Widget content =
                Text('Are you sure you don´t want to create a profile?');
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
                      'I will do it later'.toUpperCase(),
                      style: Theme.of(context).textTheme.button!.copyWith(
                          fontSize: 12, color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Modular.to.pushNamedAndRemoveUntil(
                          "/community/", (p0) => false);
                    },
                  ),
                ],
              ),
            ];
            showMessage(context,
                title: 'message'.toUpperCase(),
                content: content,
                actions: actions);
          },
        ),
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
                    'Create your',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor, fontSize: 30),
                  ),
                ),
                Text(
                  'TechFrenetic Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 25),
                createProfileForm(),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: StreamBuilder(
                        stream: store.formValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.hasData && !_isLoading
                                ? () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    bool createProfile =
                                        await store.createProfile();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (createProfile) {
                                      const SnackBar(
                                        content: Text(
                                            'You are part of the tech frenetic cummunity now'),
                                      );
                                      Modular.to.pushNamedAndRemoveUntil(
                                          '/choose_avatar', (p0) => false);
                                    } else {
                                      debugPrint("Profile not created");
                                    }
                                  }
                                : null,
                            child: Text(
                              'Continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero),
                              ),
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

  Widget createProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: store.companynameStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: 'What´s your company name?',
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
              onChanged: store.changeCompanyName,
            );
          },
        ),
        const SizedBox(height: 25),
        StreamBuilder<Object>(
            stream: store.professionStream,
            builder: (context, snapshot) {
              return DropdownButton<String>(
                value: defaultProfession,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                hint: Text(
                  'Your profession',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                ),
                items: itemsProfession.map(
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
                      defaultProfession = newValue;
                      debugPrint(defaultProfession);
                      store.changeProfession(defaultProfession!);
                      debugPrint(defaultProfession);
                    },
                  );
                },
              );
            }),
        const SizedBox(height: 25),
        StreamBuilder(
          stream: store.countryStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                'Your country',
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
        const SizedBox(height: 25),
        Text(
          'Description',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        StreamBuilder(
          stream: store.descriptionStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText:
                    'Tech passionate in Developing advanced solutions for businesses to eneable transformation and evolution.',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText:
                    snapshot.hasError ? 'Ingresa una descripcion corta' : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeDescription,
            );
          },
        ),
      ],
    );
  }
}
