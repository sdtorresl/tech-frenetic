import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      debugPrint("Not sign");
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
          stream: store.nameStream,
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
              onChanged: store.changeName,
            );
          },
        ),
        const SizedBox(height: 25),
        StreamBuilder(
          stream: null,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<String> items = [
              'profession 1',
              'profession 2',
              'profession 3',
              'profession 4',
            ];
            String? defaultValue;

            return DropdownButton<String>(
              value: defaultValue,
              isExpanded: true,
              underline: Container(
                height: 0.5,
                color: Colors.black,
              ),
              onChanged: (newValue) {
                setState(
                  () {
                    defaultValue = newValue!;
                  },
                );
              },
              hint: Text(
                'Your profession',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
              items: items.map(
                (String valueItem) {
                  return DropdownMenuItem<String>(
                    child: Text(valueItem),
                    value: valueItem,
                  );
                },
              ).toList(),
            );
          },
        ),
        const SizedBox(height: 25),
        StreamBuilder(
          stream: null,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<String> items = [
              'country 1',
              'country 2',
              'country 3',
              'country 4',
              'country 5',
              'country 6',
              'country 7',
              'country 8',
              'country 9',
              'country 10',
              'country 11',
              'country 12',
              'country 13',
              'country 14',
            ];
            String? defaultValue;

            return DropdownButton<String>(
              value: defaultValue,
              isExpanded: true,
              underline: Container(
                height: 0.5,
                color: Colors.black,
              ),
              onChanged: (newValue) {
                setState(
                  () {
                    defaultValue = newValue!;
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
