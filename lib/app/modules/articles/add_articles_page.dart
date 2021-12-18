import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class AddArticlesPage extends StatefulWidget {
  final String title;
  const AddArticlesPage({Key? key, this.title = 'AddArticlesPage'})
      : super(key: key);
  @override
  AddArticlesPageState createState() => AddArticlesPageState();
}

class AddArticlesPageState extends State<AddArticlesPage> {
  late List<String> _selectedTags;
  TextEditingController tagsController = TextEditingController();

  File? image;

  @override
  void initState() {
    _selectedTags = [];
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ArticlesProvider postArticle = ArticlesProvider();
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
                  "Write an",
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "article",
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
          _titleField(context),
          _imageField(context),
          _descriptionField(context),
          _articleField(context),
          _categoriesField(context),
          _tagsField(context),
          const SizedBox(
            height: 20,
          ),
          _formButtons(context),
        ],
      ),
    );
  }

  _titleField(BuildContext context) {
    return const TextField(
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(labelText: "Título"),
    );
  }

  _imageField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text("Selecciona una imagen"),
        GestureDetector(
          onTap: () => pickImage(),
          child: image != null
              ? Image.file(image!)
              : Container(
                  color: Colors.blueGrey,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(50),
                  child: const Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
        ),
      ],
    );
  }

  _articleField(BuildContext context) {
    return const TextField(
      maxLines: 20,
      minLines: 5,
      decoration: InputDecoration(labelText: "Contenido"),
    );
  }

  _categoriesField(BuildContext context) {
    return const TextField(
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(labelText: "Categorías"),
    );
  }

  _descriptionField(BuildContext context) {
    return const TextField(
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(labelText: "Descripción corta"),
    );
  }

  _tagsField(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: tagsController,
          decoration: const InputDecoration(labelText: "Tags"),
          onSubmitted: (String value) {
            setState(() {
              _selectedTags.add(value);
              tagsController.text = "";
            });
          },
        ),
        Wrap(
          spacing: 5,
          children: List<Widget>.generate(_selectedTags.length, (int index) {
            return Chip(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              label: Text(
                _selectedTags[index],
                style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),
              ),
              deleteIcon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onDeleted: () {
                setState(() {
                  _selectedTags.removeAt(index);
                });
              },
              elevation: 1,
            );
          }),
        ),
      ],
    );
  }

  _formButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => debugPrint("Publish"),
            child: Text(AppLocalizations.of(context)!.publish),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // background
              onPrimary: Theme.of(context).primaryColor,
              side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
