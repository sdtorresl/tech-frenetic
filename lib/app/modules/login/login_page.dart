import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(5, 20, 47, 1),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.login_create_one,
          style: TextStyle(
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
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Colors.grey,
            ),
            hintText: AppLocalizations.of(context)!.login_label_email,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            hintText: AppLocalizations.of(context)!.login_label_pass,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return const Center(
      child: Text(
        'Forgot your password',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontFamily: 'NunitoSan',
            color: Colors.black),
      ),
    );
  }

  Widget _logginButton(context) {
    return ElevatedButton(
      onPressed: () => print("Login"),
      child: Text(
        AppLocalizations.of(context)!.login_title,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: 'NunitoSan',
            color: Colors.white),
      ),
    );
  }
}
