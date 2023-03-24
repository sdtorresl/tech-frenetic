// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_number_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CardNumberStore on _CardNumberStoreBase, Store {
  late final _$cardNumberAtom =
      Atom(name: '_CardNumberStoreBase.cardNumber', context: context);

  @override
  String? get cardNumber {
    _$cardNumberAtom.reportRead();
    return super.cardNumber;
  }

  @override
  set cardNumber(String? value) {
    _$cardNumberAtom.reportWrite(value, super.cardNumber, () {
      super.cardNumber = value;
    });
  }

  late final _$expirationDateAtom =
      Atom(name: '_CardNumberStoreBase.expirationDate', context: context);

  @override
  String? get expirationDate {
    _$expirationDateAtom.reportRead();
    return super.expirationDate;
  }

  @override
  set expirationDate(String? value) {
    _$expirationDateAtom.reportWrite(value, super.expirationDate, () {
      super.expirationDate = value;
    });
  }

  late final _$cvvAtom =
      Atom(name: '_CardNumberStoreBase.cvv', context: context);

  @override
  String? get cvv {
    _$cvvAtom.reportRead();
    return super.cvv;
  }

  @override
  set cvv(String? value) {
    _$cvvAtom.reportWrite(value, super.cvv, () {
      super.cvv = value;
    });
  }

  late final _$cardTypeAtom =
      Atom(name: '_CardNumberStoreBase.cardType', context: context);

  @override
  CardType get cardType {
    _$cardTypeAtom.reportRead();
    return super.cardType;
  }

  @override
  set cardType(CardType value) {
    _$cardTypeAtom.reportWrite(value, super.cardType, () {
      super.cardType = value;
    });
  }

  late final _$_CardNumberStoreBaseActionController =
      ActionController(name: '_CardNumberStoreBase', context: context);

  @override
  void setCardNumber(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.setCardNumber');
    try {
      return super.setCardNumber(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpirationMonth(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.setExpirationMonth');
    try {
      return super.setExpirationMonth(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCVV(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.setCVV');
    try {
      return super.setCVV(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCard(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.validateCard');
    try {
      return super.validateCard(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateExpiryDate(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.validateExpiryDate');
    try {
      return super.validateExpiryDate(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCVV(String? value) {
    final _$actionInfo = _$_CardNumberStoreBaseActionController.startAction(
        name: '_CardNumberStoreBase.validateCVV');
    try {
      return super.validateCVV(value);
    } finally {
      _$_CardNumberStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardNumber: ${cardNumber},
expirationDate: ${expirationDate},
cvv: ${cvv},
cardType: ${cardType}
    ''';
  }
}

mixin _$CardErrorState on _CardErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_CardErrorState.hasErrors'))
          .value;

  late final _$cardNumberAtom =
      Atom(name: '_CardErrorState.cardNumber', context: context);

  @override
  String? get cardNumber {
    _$cardNumberAtom.reportRead();
    return super.cardNumber;
  }

  @override
  set cardNumber(String? value) {
    _$cardNumberAtom.reportWrite(value, super.cardNumber, () {
      super.cardNumber = value;
    });
  }

  late final _$expirationDateAtom =
      Atom(name: '_CardErrorState.expirationDate', context: context);

  @override
  String? get expirationDate {
    _$expirationDateAtom.reportRead();
    return super.expirationDate;
  }

  @override
  set expirationDate(String? value) {
    _$expirationDateAtom.reportWrite(value, super.expirationDate, () {
      super.expirationDate = value;
    });
  }

  late final _$cvvAtom = Atom(name: '_CardErrorState.cvv', context: context);

  @override
  String? get cvv {
    _$cvvAtom.reportRead();
    return super.cvv;
  }

  @override
  set cvv(String? value) {
    _$cvvAtom.reportWrite(value, super.cvv, () {
      super.cvv = value;
    });
  }

  @override
  String toString() {
    return '''
cardNumber: ${cardNumber},
expirationDate: ${expirationDate},
cvv: ${cvv},
hasErrors: ${hasErrors}
    ''';
  }
}
