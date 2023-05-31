import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/models/image_model.dart';
import 'package:techfrenetic/app/models/video_model.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
part 'articles_store.g.dart';

class ArticlesStore = _ArticlesStore with _$ArticlesStore;

abstract class _ArticlesStore extends Disposable with Store {
  final FormErrorState error = FormErrorState();
  @observable
  String? title;
  @observable
  ImageModel? uploadedImage;
  @observable
  String? imageUrl;
  @observable
  VideoModel? uploadedVideo;
  @observable
  String? category;
  @observable
  String? description;
  @observable
  String? content;
  @observable
  ObservableList<String> selectedTags = ObservableList.of([]);
  @observable
  bool isLoading = false;

  @action
  void setTitle(String value) {
    title = value;
    printValues();
  }

  @action
  void setContent(String value) {
    content = value;
    printValues();
  }

  @action
  void setDescription(String value) {
    description = value;
    printValues();
  }

  @action
  void setCategory(String? value) {
    if (value != null) {
      category = value;
    }
    printValues();
  }

  @action
  void removeTag(int index) {
    debugPrint("Remove index $index");
    if (index < selectedTags.length) {
      debugPrint("Delete tag");
      selectedTags.removeAt(index);
    }
    printValues();
  }

  @action
  void addTag(String value) {
    if (!selectedTags.contains(value)) {
      selectedTags.add(value);
    }
    printValues();
  }

  @computed
  int get selectedTagsLength => selectedTags.length;

  @computed
  bool get isCompleted =>
      title != '' &&
      uploadedImage != null &&
      description != null &&
      content != null;

  @computed
  bool get isCompletedWithVideo =>
      title != null &&
      uploadedImage != null &&
      description != null &&
      content != null &&
      uploadedVideo != null;

  List<ReactionDisposer> _disposers = [];

  @action
  void validateTitle(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        error.title = 'Cannot be blank';
        return;
      }
    }

    error.title = null;
  }

  @action
  void validateDescription(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        error.description = 'Cannot be blank';
        return;
      }
    }

    error.description = null;
  }

  @action
  void validateContent(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        error.content = 'Cannot be blank';
        return;
      }
    }

    error.content = null;
  }

  @action
  Future<int?> addArticle() async {
    ArticlesProvider articlesProvider = ArticlesProvider();

    isLoading = true;

    ArticlesModel article = ArticlesModel(
      id: "",
      displayName: title ?? '',
      category: category,
      description: description,
      body: content,
      tags: selectedTags.join(','),
      image: uploadedImage?.id.toString(),
      title: title ?? '',
      video: uploadedVideo?.uid,
    );

    debugPrint(article.toJson());

    int? articleId = await articlesProvider.addArticle(article);

    isLoading = true;

    _clearForm();

    return articleId;
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => title, validateTitle),
      reaction((_) => description, validateDescription),
      reaction((_) => content, validateContent)
    ];
  }

  @override
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  printValues() {
    debugPrint("Title: " + title.toString());
    debugPrint("Image: " + uploadedImage.toString());
    debugPrint("Video: " + uploadedVideo.toString());
    debugPrint("Category: " + category.toString());
    debugPrint("Description: " + description.toString());
    debugPrint("Content: " + content.toString());
    debugPrint("Tags: " + selectedTags.toString());
  }

  void _clearForm() {
    title = null;
    uploadedImage = null;
    imageUrl = null;
    uploadedVideo = null;
    category = null;
    description = null;
    content = null;
    selectedTags = ObservableList.of([]);
    isLoading = false;
  }
}

// ignore: library_private_types_in_public_api
class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? title;

  @observable
  String? description;

  @observable
  String? content;

  @computed
  bool get hasErrors => title != null || description != null || content != null;
}
