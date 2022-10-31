// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_summary_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SummaryStore on _SummaryStoreBase, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_SummaryStoreBase.hasErrors'))
          .value;

  late final _$errorAtom =
      Atom(name: '_SummaryStoreBase.error', context: context);

  @override
  ErrorType? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(ErrorType? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$summaryAtom =
      Atom(name: '_SummaryStoreBase.summary', context: context);

  @override
  String get summary {
    _$summaryAtom.reportRead();
    return super.summary;
  }

  @override
  set summary(String value) {
    _$summaryAtom.reportWrite(value, super.summary, () {
      super.summary = value;
    });
  }

  late final _$_SummaryStoreBaseActionController =
      ActionController(name: '_SummaryStoreBase', context: context);

  @override
  dynamic changeSummary(dynamic summary) {
    final _$actionInfo = _$_SummaryStoreBaseActionController.startAction(
        name: '_SummaryStoreBase.changeSummary');
    try {
      return super.changeSummary(summary);
    } finally {
      _$_SummaryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validateSummary(String value) {
    final _$actionInfo = _$_SummaryStoreBaseActionController.startAction(
        name: '_SummaryStoreBase.validateSummary');
    try {
      return super.validateSummary(value);
    } finally {
      _$_SummaryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
summary: ${summary},
hasErrors: ${hasErrors}
    ''';
  }
}
