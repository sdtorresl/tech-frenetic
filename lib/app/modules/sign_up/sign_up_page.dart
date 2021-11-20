import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  @override
  Widget build(BuildContext context) {
    if (check) {
      checkBoxPerson = true;
      checkBoxCompany = false;
    } else {
      checkBoxPerson = false;
      checkBoxCompany = true;
    }
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HighlightContainer(
                  child: Text(
                    'Become a Frenetic.',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).indicatorColor,
                          fontSize: 30,
                        ),
                  ),
                ),
                Text(
                  'It´s esay!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enjoy all our public articles joining our community. You will also get access to the all content.',
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
                  'Let´s prepare your singup. First, tell us who you are?',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Checkbox(
                        value: checkBoxPerson,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onChanged: (bool? value) {
                          setState(
                            () {
                              checkBoxPerson = value!;
                              check = true;
                            },
                          );
                        }),
                    Text('Person',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16)),
                    const SizedBox(width: 30),
                    Checkbox(
                        value: checkBoxCompany,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onChanged: (bool? value) {
                          setState(
                            () {
                              checkBoxCompany = value!;
                              check = false;
                            },
                          );
                        }),
                    Text('Company',
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
                  'Your password must have:',
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
                      ' 8 or more characters',
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
                      ' Upper and lower case letters',
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
                      ' At least one number',
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
                              'I have read and accept the',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              ' terms ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.5),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'of use and',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              ' privacy policy.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.5),
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
                                    bool signIn = await store.sing();
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
                              'Continue',
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
