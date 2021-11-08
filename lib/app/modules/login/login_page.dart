import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginController> {
  bool _isPasswordHidden = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SafeArea(
              child: SizedBox(
                height: 50,
              ),
            ),
            _mainTitle(context),
            const SizedBox(
              height: 45,
            ),
            _createAccount(context),
            const SizedBox(
              height: 30,
            ),
            _loginForm(context),
            const SizedBox(
              height: 30,
            ),
            _forgotPassword(context),
            const SizedBox(
              height: 30,
            ),
            _logginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _mainTitle(context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.login_blue_title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 20, 47, 1),
            )),
        Text(
          AppLocalizations.of(context)!.login_black_title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 50,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(0, 110, 232, 1),
          ),
        ),
      ],
    );
  }

  Widget _createAccount(context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.login_intro_text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(5, 20, 47, 1),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.login_create_one,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(5, 113, 232, 1),
          ),
        ),
      ],
    );
  }

  Widget _loginForm(context) {
    return Column(
      children: [
        StreamBuilder(
          stream: store.emailStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                hintText: AppLocalizations.of(context)!.login_label_email,
                hintStyle: const TextStyle(color: Colors.grey),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeEmail,
            );
          },
        ),
        const SizedBox(height: 30),
        StreamBuilder(
          stream: store.passwordStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TextField(
              keyboardType: TextInputType.text,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                hintText: AppLocalizations.of(context)!.login_label_pass,
                hintStyle: const TextStyle(color: Colors.grey),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () =>
                      setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),
              ),
              onChanged: store.changePassword,
            );
          },
        ),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.login_forgot,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontFamily: 'NunitoSan',
            color: Colors.black),
      ),
    );
  }

  Widget _logginButton(context) {
    return StreamBuilder(
      stream: store.formValidStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData && !_isLoading
              ? () async {
                  setState(() {
                    _isLoading = true;
                  });
                  bool loggedIn = await store.login();
                  setState(() {
                    _isLoading = false;
                  });
                  if (loggedIn) {
                    Modular.to.pushNamedAndRemoveUntil("/", (p0) => false);
                  } else {
                    debugPrint("Not logged");
                  }
                }
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 20),
                      child:
                          const CircularProgressIndicator(color: Colors.white),
                    )
                  : const SizedBox(),
              Text(
                AppLocalizations.of(context)!.login_title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: 'NunitoSan',
                    color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
