import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/modules/login/login_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginController> {
  bool _isPasswordHidden = true;
  bool _isLoading = false;
  PackageInfo _packageInfo =
      PackageInfo(appName: '', buildNumber: '', packageName: '', version: '');
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            const SafeArea(
              child: SizedBox(
                height: 40,
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
            const SizedBox(
              height: 5,
            ),
            _versionInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _mainTitle(context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              fontFamily: 'NunitoSan',
            ),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.login_blue_title,
            style: const TextStyle(
              color: Color.fromRGBO(5, 20, 47, 1),
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: AppLocalizations.of(context)!.login_black_title,
            style: const TextStyle(
              color: Color.fromRGBO(0, 110, 232, 1),
            ),
          ),
        ],
      ),
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
        GestureDetector(
          child: Text(
            AppLocalizations.of(context)!.login_create_one,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              decoration: TextDecoration.underline,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 113, 232, 1),
            ),
          ),
          onTap: () => Modular.to.pushNamed("/sign"),
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
      child: GestureDetector(
        child: Text(
          AppLocalizations.of(context)!.login_forgot,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              decoration: TextDecoration.underline,
              fontFamily: 'NunitoSan',
              color: Colors.black),
        ),
        onTap: () => Modular.to.pushNamed("/forgot"),
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
                    debugPrint("Open community");
                    Modular.to.pushNamedAndRemoveUntil(
                        "/community/", ModalRoute.withName("/"));
                  } else {
                    Widget content = Text(AppLocalizations.of(context)!
                        .error_sorry_unrecognized_username_or_password);
                    List<Widget> actions = [
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.close.toUpperCase(),
                          style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ];
                    showMessage(context,
                        title: AppLocalizations.of(context)!.error,
                        content: content,
                        actions: actions);
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

  Widget _versionInfo(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        "Versión ${_packageInfo.version}",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
