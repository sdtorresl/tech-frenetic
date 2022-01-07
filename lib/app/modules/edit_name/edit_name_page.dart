import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  List<String> items = [
    'Category',
    'Applications',
    'Cloud',
    'Consulting & Sales',
    'Cibersecurity',
    'Networking',
    'Servers & PCs',
    'Storage',
  ];

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
                  "Profile",
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
    String defaultValue = items.first;
    return Form(
      child: ListView(
        children: [
          const SizedBox(height: 60),
          StreamBuilder(
            stream: null,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'your name',
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
          DropdownButton<String>(
            value: defaultValue,
            isExpanded: true,
            underline: Container(
              height: 0.5,
              color: Colors.black,
            ),
            hint: Text(
              'Your profession',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
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
                  defaultValue = newValue!;
                  debugPrint(defaultValue);
                },
              );
            },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () => debugPrint('hola'), child: const Text('Save'))
        ],
      ),
    );
  }
}
