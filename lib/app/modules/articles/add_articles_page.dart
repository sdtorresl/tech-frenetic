import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/image_model.dart';
import 'package:techfrenetic/app/modules/articles/widgets/image_selection_widget.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class AddArticlesPage extends StatefulWidget {
  final void Function(int articleId)? onArticleAdded;
  const AddArticlesPage({Key? key, this.onArticleAdded}) : super(key: key);
  @override
  AddArticlesPageState createState() => AddArticlesPageState();
}

CategoriesProvider categories = CategoriesProvider();

class AddArticlesPageState extends State<AddArticlesPage> {
  late List<String> _selectedTags;
  TextEditingController tagsController = TextEditingController();
  final ArticlesProvider articlesProvider = ArticlesProvider();

  String? title;
  ImageModel? uploadedImage;
  String? category = '1';
  String? description;
  String? content;
  bool _isLoading = false;

  @override
  void initState() {
    _selectedTags = [];
    super.initState();
  }

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

  Widget _articleForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          _titleField(context),
          ImageSelectionWidget(
            onImageLoaded: (image) => uploadedImage = image,
          ),
          _descriptionField(context),
          _articleField(context),
          const SizedBox(height: 60),
          _categoriesField(context),
          const SizedBox(height: 50),
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
    return TextField(
      maxLines: 5,
      minLines: 3,
      decoration: const InputDecoration(labelText: "Título"),
      onChanged: (text) {
        setState(
          () {
            title = text;
          },
        );
      },
    );
  }

  _articleField(BuildContext context) {
    return TextField(
      maxLines: 20,
      minLines: 5,
      decoration: const InputDecoration(labelText: "Contenido"),
      onChanged: (text) {
        setState(
          () {
            content = text;
          },
        );
      },
    );
  }

  _categoriesField(BuildContext context) {
    return FutureBuilder(
      future: categories.getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<String> categoriesNames = [];
        if (snapshot.hasData) {
          List<CategoriesModel> categoriesModel = snapshot.data;
          for (var models in categoriesModel) {
            categoriesNames.add(models.category);
          }
          String? defaultValue = categoriesNames.first;
          return DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: "Categorías",
            ),
            value: defaultValue,
            isExpanded: true,
            items: categoriesNames.map(
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
                  for (var model in categoriesModel) {
                    if (model.category == newValue) {
                      category = model.id;
                    }

                    debugPrint(category);
                  }
                  defaultValue = newValue;
                  debugPrint(defaultValue);
                },
              );
            },
          );
        } else {
          return Text(
            'Loading categories...',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  _descriptionField(BuildContext context) {
    return TextField(
      maxLines: 5,
      minLines: 3,
      decoration: const InputDecoration(labelText: "Descripción corta"),
      onChanged: (text) {
        setState(
          () {
            description = text;
          },
        );
      },
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
    bool isCompleted = title != '' &&
        uploadedImage != null &&
        category != "" &&
        description != "" &&
        content != "";

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: isCompleted && !_isLoading ? _addArticle : null,
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
        ),
      ],
    );
  }

  _addArticle() async {
    setState(() {
      _isLoading = true;
    });
    int? articleId = await articlesProvider.addArticle(
        title!,
        int.parse(category!),
        description ?? '',
        content ?? '',
        _selectedTags.join(", "),
        uploadedImage!.id.toString());
    setState(() {
      _isLoading = true;
    });
    if (articleId != null) {
      if (widget.onArticleAdded != null) {
        widget.onArticleAdded!(articleId);
      }
      Modular.to.popAndPushNamed("/community");
    } else {
      debugPrint('Article not posted');
    }
  }
}
