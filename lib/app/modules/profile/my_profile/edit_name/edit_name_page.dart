import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/edit_name/profile_bloc.dart';
import 'package:techfrenetic/app/providers/professions_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

ProfessionsProvider professions = ProfessionsProvider();

class _EditNamePageState extends State<EditNamePage> {
  late final ProfileBloc _profileBloc;
  late UserPreferences _prefs;
  String? defaultValue;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _prefs = UserPreferences();

    if (_prefs.userName != null) {
      _profileBloc.changeName(_prefs.userName!);
    }
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Column(children: [
          _header(context),
          Expanded(
            child: _articleForm(context),
          ),
        ]),
      ),
    );
  }

  Widget _header(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HighlightContainer(
                    child: Text(
                  AppLocalizations.of(context)!.profile_edit_about_blue,
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.profile_edit_profile,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                )
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Divider(
          color: theme.primaryColor,
          thickness: 1,
        )
      ],
    );
  }

  Widget _articleForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          const SizedBox(height: 60),
          _nameField(),
          const SizedBox(height: 60),
          _professionField(),
          const SizedBox(height: 60),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return StreamBuilder(
      stream: _profileBloc.nameFormStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        debugPrint("Data: ${snapshot.data.toString()}");
        debugPrint(snapshot.hasError.toString());
        return ElevatedButton(
          onPressed: !snapshot.hasData ? null : saveName,
          child: Text(AppLocalizations.of(context)!.profile_save),
        );
      },
    );
  }

  Widget _professionField() {
    return FutureBuilder(
      future: professions.getProfessions(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoriesModel>> snapshot) {
        List<String> professionsNames = [];
        if (snapshot.hasData) {
          List<CategoriesModel> professions = snapshot.data!;
          for (var models in professions) {
            professionsNames.add(models.category);
          }

          return StreamBuilder<String>(
            stream: _profileBloc.professionStream,
            builder: (context, snapshot) {
              return DropdownButton<String>(
                value: _profileBloc.profession,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                hint: Text(
                  AppLocalizations.of(context)!.profile_your_profession,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                ),
                items: professionsNames.map(
                  (String valueItem) {
                    return DropdownMenuItem<String>(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  if (value != null) {
                    _profileBloc.changeProfession(value);
                  }
                },
              );
            },
          );
        } else {
          return Text(
            'Loading Professions...',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  Widget _nameField() {
    return StreamBuilder<String>(
      stream: _profileBloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          initialValue: _profileBloc.name,
          onChanged: _profileBloc.changeName,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.profile_your_name,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).hintColor),
            errorText: snapshot.hasError ? snapshot.error.toString() : "",
            errorStyle: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.red),
          ),
        );
      },
    );
  }

  saveName() async {
    debugPrint(_profileBloc.name);
    debugPrint(_profileBloc.profession);
  }
}
