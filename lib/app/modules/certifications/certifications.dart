import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class CertificationsPage extends StatefulWidget {
  const CertificationsPage({Key? key}) : super(key: key);

  @override
  _CertificationsPageState createState() => _CertificationsPageState();
}

class _CertificationsPageState extends State<CertificationsPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Column(children: [
          _header(context),
          Expanded(
            child: _articleForm(context),
          ),
        ]),
      ),
    );
  }

  Widget _header(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HighlightContainer(
                    child: Text(
                  "Edit",
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Certifications",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                )
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Divider(
          color: theme.primaryColor,
          thickness: 1,
        )
      ],
    );
  }

  _articleForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          const SizedBox(height: 60),
          Text(
            'Certification name',
            style: Theme.of(context).textTheme.headline1,
          ),
          StreamBuilder(
            stream: null,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return TextFormField(
                decoration: InputDecoration(
                  suffixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: FloatingActionButton(
                      onPressed: () => debugPrint('kkkko'),
                      elevation: 0,
                      child: const Icon(Icons.close),
                    ),
                  ),
                  hintText: '',
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
              );
            },
          ),
          const SizedBox(height: 60),
          HighlightContainer(
            child: Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        onPressed: () => debugPrint('kkkko'),
                        elevation: 0,
                        child: const Icon(Icons.add),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Add certifications',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () => debugPrint('hola'), child: const Text('Save'))
        ],
      ),
    );
  }
}
