import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/modules/sign_up/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
  bool _isPasswordHidden1 = true;
  bool _isPasswordHidden2 = true;

  bool? checkBoxPerson;
  bool? checkBoxCompany;

  bool check = true;
  bool _isLoading = false;
  String? person;
  String? company;

  @override
  Widget build(BuildContext context) {
    if (check == true) {
      person = 'person';
      company = '';
      checkBoxPerson = true;
      checkBoxCompany = false;
    } else if (check == false) {
      company = 'company';
      person = '';
      checkBoxPerson = false;
      checkBoxCompany = true;
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.become,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).indicatorColor,
                          fontSize: 30,
                        ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.its_easy,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.txt_claim,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        width: 2.00,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  child: const SizedBox(width: 35),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.intro1,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    StreamBuilder(
                      stream: store.personStream,
                      builder: (context, snapshot) {
                        store.changePerson(person!);
                        return Checkbox(
                          value: checkBoxPerson,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onChanged: (bool? value) {
                            setState(
                              () {
                                check = true;
                              },
                            );
                          },
                        );
                      },
                    ),
                    Text(AppLocalizations.of(context)!.person,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16)),
                    const SizedBox(width: 30),
                    StreamBuilder(
                      stream: store.companyStream,
                      builder: (context, snapshot) {
                        store.changeCompany(company!);

                        return Checkbox(
                          value: checkBoxCompany,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onChanged: (bool? value) {
                            setState(
                              () {
                                check = false;
                              },
                            );
                          },
                        );
                      },
                    ),
                    Text(AppLocalizations.of(context)!.company,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                form(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.have_password,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).errorColor,
                    ),
                    Text(
                      ' ' + AppLocalizations.of(context)!.pwd_minchars,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).errorColor, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).errorColor,
                    ),
                    Text(
                      ' ' + AppLocalizations.of(context)!.pwd_lowper,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).errorColor, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).errorColor,
                    ),
                    Text(
                      ' ' + AppLocalizations.of(context)!.pwd_number,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).errorColor, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    StreamBuilder(
                      stream: store.termsStream,
                      initialData: false,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Checkbox(
                          value:
                              snapshot.hasData && snapshot.data ? true : false,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                store.changeTerms(value!);
                              },
                            );
                          },
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.terms_line1,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            GestureDetector(
                              child: Text(
                                ' ' +
                                    AppLocalizations.of(context)!.terms_link1 +
                                    ' ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.5),
                              ),
                              onTap: () => Modular.to.pushNamed('/terms'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.terms_line2,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            GestureDetector(
                              child: Text(
                                ' ' + AppLocalizations.of(context)!.terms_link2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.5),
                              ),
                              onTap: () =>
                                  Modular.to.pushNamed('/privacy_policy'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 800,
                    child: StreamBuilder<Object>(
                        stream: store.formValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.hasData && !_isLoading
                                ? () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    bool signIn = await store.sign();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (signIn) {
                                      const SnackBar(
                                        content: Text(
                                            'You are part of the tech frenetic cummunity now'),
                                      );
                                      Modular.to.pushNamedAndRemoveUntil(
                                          '/create_profile', (p0) => false);
                                    } else {
                                      debugPrint("Not sign");
                                    }
                                  }
                                : null,
                            child: Text(
                              AppLocalizations.of(context)!.continue_button,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        StreamBuilder<Object>(
            stream: store.nameStream,
            builder: (context, snapshot) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'What´s your name?',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onChanged: store.changeName,
              );
            }),
        const SizedBox(height: 20),
        StreamBuilder(
            stream: store.emailStream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.red),
                ),
                onChanged: store.changeEmail,
              );
            }),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: store.passwordStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TextFormField(
              obscureText: _isPasswordHidden1,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Create password',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden1
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordHidden1 = !_isPasswordHidden1),
                ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changePassword,
            );
          },
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: store.passwordStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TextFormField(
              obscureText: _isPasswordHidden2,
              decoration: InputDecoration(
                hintText: 'Confirm your password',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden2
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      setState(() => _isPasswordHidden2 = !_isPasswordHidden2),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
