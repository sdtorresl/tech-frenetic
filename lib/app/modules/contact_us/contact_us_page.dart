import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_controller.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

List<String> items = [
  'Subject',
  'Subject1',
  'Subject2',
  'Subject3',
  'Subject4',
];
String? defaultValue = items.first;

class _ContactUsPageState
    extends ModularState<ContactUsPage, ContactUsController> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          contacInfo(),
          const SizedBox(height: 20),
          getInTouch(),
        ],
      ),
    );
  }

  Widget contacInfo() {
    return Container(
      color: Theme.of(context).indicatorColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                AppLocalizations.of(context)!.contact,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Theme.of(context).indicatorColor, fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.call_us,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            Text(AppLocalizations.of(context)!.phone + '(+57 3104655112)',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    )),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_sharp,
                  color: Colors.white,
                ),
                Text(
                  ' (+57 3104655112)',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              width: 400,
              height: .5,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.write_us,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            Text(
              'memo@techfrenetic.com',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              width: 400,
              height: .5,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.find_us,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            Text('Cra 11 # 70-66 Oficina 209',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    )),
            Text(
              'Bogotá. Colombia.',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget getInTouch() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.get_in,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor, fontSize: 30),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.touch,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.compleate_the_information,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            Container(
              color: Theme.of(context).primaryColor,
              width: 20,
              height: 1.5,
            ),
            const SizedBox(height: 30),
            form(),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 400,
                child: StreamBuilder<Object>(
                    stream: store.formValidStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: snapshot.hasData && !_isLoading
                            ? () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                bool createProfile = await store.contactUs();
                                setState(() {
                                  _isLoading = false;
                                });
                                if (createProfile) {
                                  debugPrint('Email Send');
                                  // Modular.to.pushNamedAndRemoveUntil(
                                  //     '/choose_avatar', (p0) => false);
                                } else {
                                  debugPrint("Email not Send");
                                }
                              }
                            : null,
                        child: Text(
                          AppLocalizations.of(context)!.send,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: store.nameStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.your_name,
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
              onChanged: store.changeName,
            );
          },
        ),
        const SizedBox(height: 40),
        StreamBuilder(
          stream: store.emailStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.whats_your_name,
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
                onChanged: store.changeEmail);
          },
        ),
        const SizedBox(height: 40),
        StreamBuilder(
          stream: store.cellphoneStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.your_phone,
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
              onChanged: store.changePhone,
            );
          },
        ),
        const SizedBox(height: 40),
        StreamBuilder(
            stream: store.subjectStream,
            builder: (context, snapshot) {
              return DropdownButton<String>(
                value: defaultValue,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                items: items.map(
                  (String valueItem) {
                    return DropdownMenuItem<String>(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(
                    () {
                      defaultValue = newValue;
                      store.changeSubject(defaultValue!);
                    },
                  );
                },
              );
            }),
        const SizedBox(height: 40),
        Text(
          AppLocalizations.of(context)!.message2,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: store.descriptionStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.write + '...',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: snapshot.hasError
                    ? AppLocalizations.of(context)!.write_a_message
                    : null,
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: store.changeDescription,
            );
          },
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            StreamBuilder(
              stream: store.termsStream,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Checkbox(
                  value: snapshot.hasData && snapshot.data ? true : false,
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
                    Text(
                      ' ' + AppLocalizations.of(context)!.terms_link1 + ' ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.terms_line2,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      ' ' + AppLocalizations.of(context)!.terms_link2,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
