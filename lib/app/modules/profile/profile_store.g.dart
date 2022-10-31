// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStoreBase, Store {
  late final _$indexAtom =
      Atom(name: '_ProfileStoreBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$loggedUserAtom =
      Atom(name: '_ProfileStoreBase.loggedUser', context: context);

  @override
  UserModel? get loggedUser {
    _$loggedUserAtom.reportRead();
    return super.loggedUser;
  }

  @override
  set loggedUser(UserModel? value) {
    _$loggedUserAtom.reportWrite(value, super.loggedUser, () {
      super.loggedUser = value;
    });
  }

  late final _$followingAtom =
      Atom(name: '_ProfileStoreBase.following', context: context);

  @override
  int get following {
    _$followingAtom.reportRead();
    return super.following;
  }

  @override
  set following(int value) {
    _$followingAtom.reportWrite(value, super.following, () {
      super.following = value;
    });
  }

  late final _$followersAtom =
      Atom(name: '_ProfileStoreBase.followers', context: context);

  @override
  int get followers {
    _$followersAtom.reportRead();
    return super.followers;
  }

  @override
  set followers(int value) {
    _$followersAtom.reportWrite(value, super.followers, () {
      super.followers = value;
    });
  }

  @override
  String toString() {
    return '''
index: ${index},
loggedUser: ${loggedUser},
following: ${following},
followers: ${followers}
    ''';
  }
}
