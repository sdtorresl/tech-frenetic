import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, ForgotPasswordController> {
  bool _isLoading = false;

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
                )),
                Text(
                  AppLocalizations.of(context)!.reset_black,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.reset_instructions,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 30),
                StreamBuilder(
                  stream: store.emailStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Theme.of(context).hintColor),
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            errorStyle: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.red),
                          ),
                          onChanged: store.changeEmail,
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: !_isLoading && snapshot.hasData
                              ? () => _recoverPassword()
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLoading
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(right: 20),
                                      child: const CircularProgressIndicator(
                                          color: Colors.white),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  },
                ),
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

  _recoverPassword() {
    SnackBar snackBar = SnackBar(
      content: Text(AppLocalizations.of(context)!.password_reset_error),
      action: SnackBarAction(
        label: AppLocalizations.of(context)!.button_accept,
        onPressed: () => Modular.to.pop(),
      ),
    );

    setState(() {
      _isLoading = true;
    });

    store.recoverPassword().then((value) {
      if (value) {
        snackBar = SnackBar(
          content:
              Text(AppLocalizations.of(context)!.password_reset_confirmation),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.button_accept,
            onPressed: () => Modular.to.navigate('/login'),
          ),
        );
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
