import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_controller.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState
    extends ModularState<ContactUsPage, ContactUsController> {
  bool _isLoading = false;
  CategoriesProvider _categoriesProvider = CategoriesProvider();
  String? _selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
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
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
          Text(
            AppLocalizations.of(context)!.phone,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
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
        ],
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
                            ? _sendContact
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
                              AppLocalizations.of(context)!.send,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
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
                errorText: snapshot.hasError
                    ? TFError.getError(context, snapshot.error as ErrorType)
                    : null,
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
        _subjectsDropdown(),
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

  StreamBuilder<String> _subjectsDropdown() {
    return StreamBuilder(
      stream: store.subjectStream,
      builder: (context, snapshot) {
        List<CategoriesModel> subjects = [];
        return FutureBuilder(
          future: _categoriesProvider.getSubjects(),
          initialData: subjects,
          builder: (BuildContext context,
              AsyncSnapshot<List<CategoriesModel>> snapshot) {
            if (snapshot.hasData) {
              subjects = snapshot.data!;
              return DropdownButton<String>(
                value: _selectedSubject,
                isExpanded: true,
                underline: Container(
                  height: 0.5,
                  color: Colors.black,
                ),
                items: subjects.map(
                  (CategoriesModel subject) {
                    return DropdownMenuItem<String>(
                      child: Text(subject.category),
                      value: subject.id,
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(
                    () {
                      _selectedSubject = newValue;
                      store.changeSubject(newValue!);
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  _sendContact() async {
    setState(() {
      _isLoading = true;
    });
    bool contactSent = await store.contactUs();
    setState(() {
      _isLoading = false;
    });

    SnackBar snackBar;
    if (contactSent) {
      Modular.to.pushNamedAndRemoveUntil('/', (p) => true);
      snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.message_contact_sent),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.button_accept,
          onPressed: () {},
        ),
      );
    } else {
      snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.message_error),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.close,
          onPressed: () {},
        ),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
