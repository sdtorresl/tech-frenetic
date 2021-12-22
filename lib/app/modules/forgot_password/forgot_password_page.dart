import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Modular.to.pushNamed("/login"),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
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
                    return TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Email',
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
                    );
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => debugPrint('hola'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.send_email,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
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
                ),
                const SizedBox(height: 30),
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
}
