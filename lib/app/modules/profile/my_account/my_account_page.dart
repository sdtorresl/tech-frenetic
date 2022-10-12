import 'package:techfrenetic/app/core/exceptions.dart';

import './my_account_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/providers/countries_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/separator.dart';
import 'package:techfrenetic/app/widgets/validate_text_widget.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState
    extends ModularState<MyAccountPage, MyAccountController> {
  final CountriesProvider _countriesProvider = CountriesProvider();
  final UserProvider _userProvider = UserProvider();
  UserModel? _user;

  bool _isLoading = false;
  bool _isSavingPassword = false;
  bool _isSendingEmail = false;
  bool _showPasswordForm = false;
  bool _isTokenHidden = true;
  bool _isPasswordHidden = true;
  String _confirmationPassword = '';

  final _emailController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _dateController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      store.changeEmail(_emailController.text);
    });

    _cellphoneController.addListener(() {
      store.changeCellphone(_cellphoneController.text);
    });

    _dateController.addListener(() {
      store.changeBirthdate(_dateFormat.parse(_dateController.text));
    });

    _userProvider.getLoggedUser().then((user) {
      setState(() {
        _user = user;
      });
      if (user != null) {
        if (user.mail != null) {
          _emailController.text = user.mail!;
        }
        if (user.cellphone != null) {
          _cellphoneController.text = user.cellphone!;
        }
        if (user.birthdate != null) {
          _dateController.text = _dateFormat.format(user.birthdate!);
        }
        if (user.location != null) {
          store.changeCountry(user.location!);
        }
      }
    });
  }

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
            _userDataForm(context),
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

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  Widget _userDataForm(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _emailField(),
          const SizedBox(height: 30),
          _countriesField(context),
          const SizedBox(height: 30),
          _phoneField(context),
          const SizedBox(height: 30),
          _birthdateField(context),
          const SizedBox(height: 30),
          updateButton(),
        ],
      ),
    );
  }

  Widget _birthdateField(context) {
    return Column(
      children: [
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

  Widget _phoneField(context) {
    return Column(
      children: [
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
              controller: _cellphoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.phone_number,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).highlightColor),
                errorText:
                    snapshot.hasError ? 'Ingrese un numero de telefono' : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _countriesField(context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.your_country,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        StreamBuilder(
          stream: store.countryStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return FutureBuilder(
              future: _countriesProvider.getCountries(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<String> countriesNames = [];
                if (snapshot.hasData) {
                  List<CategoriesModel> categoriesModel = snapshot.data;
                  for (var models in categoriesModel) {
                    countriesNames.add(models.category);
                  }
                }
                return DropdownButton<String>(
                  value: store.country,
                  isExpanded: true,
                  underline: Container(
                    height: 0.5,
                    color: Colors.black,
                  ),
                  onChanged: (country) {
                    store.changeCountry(country!);
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
              },
            );
          },
        ),
      ],
    );
  }

  Widget _emailField() {
    return Column(
      children: [
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
            return TextFormField(
              controller: _emailController,
              readOnly: true,
              decoration: InputDecoration(
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _passwordchange(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Separator(separatorWidth: double.infinity),
          const SizedBox(height: 15.0),
          Text(
            AppLocalizations.of(context)!.password,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.last_changed + ': '),
          const SizedBox(height: 20),
          _showPasswordForm ? _passwordForm() : _changePasswordButton(),
        ],
      ),
    );
  }

  Widget _passwordForm() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.profile_password_instructions,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        StreamBuilder(
          stream: store.tokenStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              obscureText: _isTokenHidden,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.password_token,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                  icon: Icon(
                      _isTokenHidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () =>
                      setState(() => _isTokenHidden = !_isTokenHidden),
                ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: (value) {
                store.changeToken(value);
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: store.newPasswordStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              obscureText: _isPasswordHidden,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.password_new,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: (value) {
                store.changeNewPassword(value);
                store.changeNewConfirmationPassword(
                    value == _confirmationPassword);
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: store.passwordConfirmationStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            //String password = snapshot.data ?? '';
            return TextFormField(
              obscureText: _isPasswordHidden,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.password_confirm,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: (value) {
                store.changeNewConfirmationPassword(value == store.newPassword);
                setState(() {
                  _confirmationPassword = value;
                });
              },
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        _passwordValidation(),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() {
                  _showPasswordForm = !_showPasswordForm;
                }),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  side: const BorderSide(width: 1.5, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed:
                    !_isSavingPassword ? () => _updatePassword(context) : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isSavingPassword
                        ? Container(
                            height: 20,
                            width: 40,
                            child: const CircularProgressIndicator(),
                            padding: const EdgeInsets.only(right: 20),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      AppLocalizations.of(context)!.save_changes,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _passwordValidation() {
    return StreamBuilder(
      stream: store.newPasswordStream,
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String password = snapshot.data ?? '';

        bool passwordLength = password.length >= 8;
        bool passwordHasNumbers = RegExp(r'\d').hasMatch(password);
        bool passwordHasMixedCase = password.contains(RegExp(r'[A-Z]')) &&
            password.contains(RegExp(r'[a-z]'));
        bool passwordsMatch = password == _confirmationPassword;

        return Column(
          children: [
            ValidateTextWidget(
                isValid: passwordLength,
                text: AppLocalizations.of(context)!.pwd_minchars),
            const SizedBox(height: 10),
            ValidateTextWidget(
                isValid: passwordHasMixedCase,
                text: AppLocalizations.of(context)!.pwd_lowper),
            const SizedBox(height: 10),
            ValidateTextWidget(
                isValid: passwordHasNumbers,
                text: AppLocalizations.of(context)!.pwd_number),
            const SizedBox(height: 10),
            ValidateTextWidget(
                isValid: passwordsMatch,
                text: AppLocalizations.of(context)!.pwd_match),
          ],
        );
      },
    );
  }

  Widget updateButton() {
    return StreamBuilder<bool>(
      stream: store.formValidStream,
      builder: (context, snapshot) {
        bool formVald = false;
        if (snapshot.hasData) {
          formVald = snapshot.data!;
        }
        return ElevatedButton(
          onPressed: !_isLoading && formVald
              ? () => _updatePersonalData(context)
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? Container(
                      height: 20,
                      width: 40,
                      child: const CircularProgressIndicator(),
                      padding: const EdgeInsets.only(right: 20),
                    )
                  : const SizedBox.shrink(),
              Text(
                AppLocalizations.of(context)!.save_changes,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _changePasswordButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _user == null ? null : _requestToken,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isSendingEmail
                ? Container(
                    height: 20,
                    width: 40,
                    child: const CircularProgressIndicator(),
                    padding: const EdgeInsets.only(right: 20),
                  )
                : const SizedBox.shrink(),
            Text(
              AppLocalizations.of(context)!.change_password,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Theme.of(context).indicatorColor),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          elevation: 0,
          side: const BorderSide(width: 1.5, color: Colors.black),
        ),
      ),
    );
  }

  void _updatePersonalData(context) async {
    setState(() {
      _isLoading = true;
    });

    store.update().then(
      (updated) {
        List<Widget> actions = [
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.close.toUpperCase(),
              style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 12, color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Modular.to.pop();
              setState(() {
                _isLoading = false;
              });
            },
          ),
        ];

        showMessage(context,
            title: updated
                ? AppLocalizations.of(context)!.message_success
                : AppLocalizations.of(context)!.error,
            content: Text(updated
                ? AppLocalizations.of(context)!.profile_account_updated
                : AppLocalizations.of(context)!.message_error),
            actions: actions);
      },
    );
  }

  void _requestToken() {
    if (_user!.mail != null) {
      setState(() {
        _isSendingEmail = true;
      });
      _userProvider.requestChangePassToken(_user!.mail!).then((sent) {
        if (sent) {
          setState(() {
            _showPasswordForm = !_showPasswordForm;
          });
        } else {
          List<Widget> actions = [
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.close.toUpperCase(),
                style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Modular.to.pop();
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ];

          showMessage(context,
              title: AppLocalizations.of(context)!.error,
              content: Text(AppLocalizations.of(context)!
                  .error_sorry_system_can_t_send_email_at_the_moment),
              actions: actions);
        }
      }).whenComplete(() {
        setState(() {
          _isSendingEmail = false;
        });
      });
    }
  }

  void _updatePassword(BuildContext context) {
    setState(() {
      _isSavingPassword = true;
    });

    List<Widget> actions = [
      TextButton(
        child: Text(
          AppLocalizations.of(context)!.close.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(fontSize: 12, color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          Modular.to.pop();
        },
      ),
    ];

    String title = '';
    Widget content = const SizedBox.shrink();

    store.updatePassword().then(
      (updated) {
        title = updated
            ? AppLocalizations.of(context)!.message_success
            : AppLocalizations.of(context)!.error;
        content = Text(updated
            ? AppLocalizations.of(context)!.password_changed
            : AppLocalizations.of(context)!.message_error);
      },
    ).catchError((error) {
      if (error is TokenInvalidException) {
        title = AppLocalizations.of(context)!.error;
        content = Text(AppLocalizations.of(context)!
            .error_name_new_pass_and_temp_pass_fields_are_required);
      }
      if (error is UserNotFoundException) {
        title = AppLocalizations.of(context)!.error;
        content = Text(AppLocalizations.of(context)!
            .error_this_user_was_not_found_or_invalid);
      }
    }).whenComplete(() {
      showMessage(context, title: title, content: content, actions: actions);
      setState(
        () {
          _isSavingPassword = false;
        },
      );
    });
  }
}
