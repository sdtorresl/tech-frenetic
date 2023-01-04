// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ArticlesStore on _ArticlesStore, Store {
  Computed<int>? _$selectedTagsLengthComputed;

  @override
  int get selectedTagsLength => (_$selectedTagsLengthComputed ??= Computed<int>(
          () => super.selectedTagsLength,
          name: '_ArticlesStore.selectedTagsLength'))
      .value;
  Computed<bool>? _$isCompletedComputed;

  @override
  bool get isCompleted =>
      (_$isCompletedComputed ??= Computed<bool>(() => super.isCompleted,
              name: '_ArticlesStore.isCompleted'))
          .value;
  Computed<bool>? _$isCompletedWithVideoComputed;

  @override
  bool get isCompletedWithVideo => (_$isCompletedWithVideoComputed ??=
          Computed<bool>(() => super.isCompletedWithVideo,
              name: '_ArticlesStore.isCompletedWithVideo'))
      .value;

  late final _$titleAtom = Atom(name: '_ArticlesStore.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$uploadedImageAtom =
      Atom(name: '_ArticlesStore.uploadedImage', context: context);

  @override
  ImageModel? get uploadedImage {
    _$uploadedImageAtom.reportRead();
    return super.uploadedImage;
  }

  @override
  set uploadedImage(ImageModel? value) {
    _$uploadedImageAtom.reportWrite(value, super.uploadedImage, () {
      super.uploadedImage = value;
    });
  }

  late final _$imageUrlAtom =
      Atom(name: '_ArticlesStore.imageUrl', context: context);

  @override
  String? get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String? value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  late final _$uploadedVideoAtom =
      Atom(name: '_ArticlesStore.uploadedVideo', context: context);

  @override
  VideoModel? get uploadedVideo {
    _$uploadedVideoAtom.reportRead();
    return super.uploadedVideo;
  }

  @override
  set uploadedVideo(VideoModel? value) {
    _$uploadedVideoAtom.reportWrite(value, super.uploadedVideo, () {
      super.uploadedVideo = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_ArticlesStore.category', context: context);

  @override
  String? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(String? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_ArticlesStore.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$contentAtom =
      Atom(name: '_ArticlesStore.content', context: context);

  @override
  String? get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String? value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  late final _$selectedTagsAtom =
      Atom(name: '_ArticlesStore.selectedTags', context: context);

  @override
  ObservableList<String> get selectedTags {
    _$selectedTagsAtom.reportRead();
    return super.selectedTags;
  }

  @override
  set selectedTags(ObservableList<String> value) {
    _$selectedTagsAtom.reportWrite(value, super.selectedTags, () {
      super.selectedTags = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ArticlesStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$addArticleAsyncAction =
      AsyncAction('_ArticlesStore.addArticle', context: context);

  @override
  Future<int?> addArticle() {
    return _$addArticleAsyncAction.run(() => super.addArticle());
  }

  late final _$_ArticlesStoreActionController =
      ActionController(name: '_ArticlesStore', context: context);

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContent(String value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.setContent');
    try {
      return super.setContent(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String? value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTag(int index) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.removeTag');
    try {
      return super.removeTag(index);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTag(String value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.addTag');
    try {
      return super.addTag(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateTitle(String? value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.validateTitle');
    try {
      return super.validateTitle(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescription(String? value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.validateDescription');
    try {
      return super.validateDescription(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateContent(String? value) {
    final _$actionInfo = _$_ArticlesStoreActionController.startAction(
        name: '_ArticlesStore.validateContent');
    try {
      return super.validateContent(value);
    } finally {
      _$_ArticlesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
uploadedImage: ${uploadedImage},
imageUrl: ${imageUrl},
uploadedVideo: ${uploadedVideo},
category: ${category},
description: ${description},
content: ${content},
selectedTags: ${selectedTags},
isLoading: ${isLoading},
selectedTagsLength: ${selectedTagsLength},
isCompleted: ${isCompleted},
isCompletedWithVideo: ${isCompletedWithVideo}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  late final _$titleAtom =
      Atom(name: '_FormErrorState.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_FormErrorState.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$contentAtom =
      Atom(name: '_FormErrorState.content', context: context);

  @override
  String? get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String? value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
content: ${content},
hasErrors: ${hasErrors}
    ''';
  }
}
