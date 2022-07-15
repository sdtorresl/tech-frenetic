import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/exceptions.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/edit_name/profile_bloc.dart';
import 'package:techfrenetic/app/providers/professions_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  final ProfessionsProvider _professionsProvider = ProfessionsProvider();
  final UserProvider _userProvider = UserProvider();
  final ProfileBloc _profileBloc = ProfileBloc();
  final TextEditingController _nameController = TextEditingController();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      _profileBloc.changeName(_nameController.text);
    });

    _userProvider.getLoggedUser().then((user) {
      if (user != null) {
        debugPrint("Logged user: ${user.userName}");
        debugPrint("Logged user: ${user.profession}");
        _nameController.text = user.userName;
        _profileBloc.changeProfession(user.profession);
      }
    });
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
              onPressed: () => Modular.to.popAndPushNamed('/profile/profile'),
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
        return ElevatedButton(
          onPressed: !snapshot.hasData ? null : _updateProfile,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isUpdating
                  ? Container(
                      height: 20,
                      width: 40,
                      child:
                          const CircularProgressIndicator(color: Colors.white),
                      padding: const EdgeInsets.only(right: 20),
                    )
                  : const SizedBox.shrink(),
              Text(AppLocalizations.of(context)!.profile_save),
            ],
          ),
        );
      },
    );
  }

  Widget _professionField() {
    return FutureBuilder(
      future: _professionsProvider.getProfessions(),
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
          controller: _nameController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.profile_your_name,
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
        );
      },
    );
  }

  void _updateProfile() async {
    if (_profileBloc.name != null && _profileBloc.profession != null) {
      setState(() {
        _isUpdating = true;
      });
      _userProvider
          .updateProfile(_profileBloc.name!, _profileBloc.profession!)
          .then((value) {
        if (value) {
          showMessage(
            context,
            title: AppLocalizations.of(context)!.message_success,
            content:
                Text(AppLocalizations.of(context)!.profile_account_updated),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.close.toUpperCase(),
                  style: Theme.of(context).textTheme.button!.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Modular.to.pop();
                  Modular.to.popAndPushNamed('/profile/profile');
                },
              ),
            ],
          );
        }
      }).catchError((error) {
        if (error is UserExistsException) {
          debugPrint("User already exists");
          showMessage(
            context,
            title: AppLocalizations.of(context)!.error,
            content: Text(AppLocalizations.of(context)!.error_user_exists),
          );
        }
      }).whenComplete(() {
        setState(() {
          _isUpdating = false;
        });
      });
    }
  }
}
