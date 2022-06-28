import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/core/exceptions.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:techfrenetic/app/widgets/password_validation_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, ForgotPasswordController> {
  bool _sendingEmail = false;
  bool _emailSent = false;
  bool _isTokenHidden = false;
  bool _isPasswordHidden = true;
  bool _isSavingPassword = false;
  String _confirmationPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(onPressed: () => Modular.to.pushNamed("/login")),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.reset_blue,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor, fontSize: 30),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.reset_black,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 30),
                !_emailSent
                    ? _sendEmailForm(context)
                    : _changePasswordForm(context),
                Center(
                  child: GestureDetector(
                    child: Text(
                      AppLocalizations.of(context)!.back_login,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          fontSize: 16),
                    ),
                    onTap: () => Modular.to.pushNamed("/login"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sendEmailButton(BuildContext context) {
    return StreamBuilder(
      stream: store.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          onPressed:
              !_sendingEmail && snapshot.hasData ? () => _sendToken() : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _sendingEmail
                  ? Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 20),
                      child:
                          const CircularProgressIndicator(color: Colors.white),
                    )
                  : const SizedBox(),
              Text(
                AppLocalizations.of(context)!.send_email,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ],
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

  Widget _emailField(BuildContext context) {
    return StreamBuilder(
      stream: store.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          readOnly: _emailSent,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.email,
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
          onChanged: store.changeEmail,
        );
      },
    );
  }

  Widget _tokenField(BuildContext context) {
    return StreamBuilder(
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
              onPressed: () => setState(() => _isTokenHidden = !_isTokenHidden),
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
    );
  }

  Widget _changePasswordForm(BuildContext context) {
    if (_emailSent) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _instructions(context),
          const SizedBox(
            height: 10,
          ),
          _usernameField(context),
          const SizedBox(
            height: 10,
          ),
          _tokenField(context),
          const SizedBox(
            height: 10,
          ),
          _newPasswordField(context),
          const SizedBox(
            height: 10,
          ),
          _confirmationPasswordField(context),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: store.newPasswordStream,
            builder: (context, AsyncSnapshot snapshot) {
              return ChangePasswordValidationWidget(
                password: snapshot.data ?? '',
                confirmationPassword: _confirmationPassword,
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          _updatePasswordForm(context),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _newPasswordField(BuildContext context) {
    return StreamBuilder(
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
              icon: Icon(
                  _isPasswordHidden ? Icons.visibility_off : Icons.visibility),
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
            store.changeNewConfirmationPassword(value == _confirmationPassword);
          },
        );
      },
    );
  }

  Widget _confirmationPasswordField(BuildContext context) {
    return StreamBuilder(
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
              icon: Icon(
                  _isPasswordHidden ? Icons.visibility_off : Icons.visibility),
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
    );
  }

  Widget _updatePasswordForm(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => setState(() {
              _emailSent = !_emailSent;
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
            child: _isSavingPassword
                ? Container(
                    height: 20,
                    width: 40,
                    child: const CircularProgressIndicator(),
                    padding: const EdgeInsets.only(right: 20),
                  )
                : Text(
                    AppLocalizations.of(context)!.save_changes,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
          ),
        ),
      ],
    );
  }

  void _sendToken() {
    SnackBar snackBar = SnackBar(
      content: Text(AppLocalizations.of(context)!.password_reset_error),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.button_accept,
        onPressed: () => Modular.to.pop(),
      ),
    );

    setState(() {
      _sendingEmail = true;
    });

    store.recoverPassword().then((value) {
      if (value) {
        setState(() {
          _emailSent = true;
        });
        /* snackBar = SnackBar(
          content:
              Text(AppLocalizations.of(context)!.password_reset_confirmation),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.button_accept,
            onPressed: () => Modular.to.navigate('/login'),
          ),
        ); */
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).whenComplete(() {
      setState(() {
        _sendingEmail = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
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

  Widget _instructions(BuildContext context) {
    return Container(
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
    );
  }

  Widget _sendEmailForm(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.reset_instructions,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 20),
        _emailField(context),
        const SizedBox(height: 40),
        _sendEmailButton(context),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            setState(() {
              _emailSent = !_emailSent;
            });
          },
          child: Text(
            AppLocalizations.of(context)!.password_token_requested,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _usernameField(BuildContext context) {
    return StreamBuilder(
      stream: store.usernameStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.username,
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
          onChanged: store.changeUsername,
        );
      },
    );
  }
}
