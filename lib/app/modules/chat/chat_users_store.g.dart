// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatUsersStore on _ChatStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ChatStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$messageEditingControllerAtom =
      Atom(name: '_ChatStoreBase.messageEditingController', context: context);

  @override
  TextEditingController get messageEditingController {
    _$messageEditingControllerAtom.reportRead();
    return super.messageEditingController;
  }

  @override
  set messageEditingController(TextEditingController value) {
    _$messageEditingControllerAtom
        .reportWrite(value, super.messageEditingController, () {
      super.messageEditingController = value;
    });
  }

  @override
  String toString() {
    return '''
loading: ${loading},
messageEditingController: ${messageEditingController}
    ''';
  }
}
