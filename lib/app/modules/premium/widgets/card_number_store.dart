import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/core/extensions.dart';
import 'package:techfrenetic/app/core/utils/card_utils.dart';
import 'package:techfrenetic/app/models/credit_card_model.dart';
import 'package:techfrenetic/app/models/enums/card_type_enum.dart';
import 'package:techfrenetic/app/models/payment_method_response.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/providers/payments_provider.dart';

part 'card_number_store.g.dart';

class CardNumberStore = _CardNumberStoreBase with _$CardNumberStore;

abstract class _CardNumberStoreBase with Store {
  final HomeStore homeStore = Modular.get();

  @observable
  String? cardNumber;

  @observable
  String? expirationDate;

  @observable
  String? cvv;

  @observable
  CardType cardType = CardType.invalid;

  List<ReactionDisposer> _disposers = [];

  final CardErrorState error = CardErrorState();

  void setupValidations() {
    _disposers = [
      reaction((_) => cardNumber, validateCard),
      reaction((_) => expirationDate, validateExpiryDate),
      reaction((_) => cvv, validateCVV)
    ];
  }

  @action
  void setCardNumber(String? value) {
    if (value != null) {
      cardNumber = value.toCreditCard();
    }
  }

  @action
  void setExpirationMonth(String? value) {
    expirationDate = value;
  }

  @action
  void setCVV(String? value) {
    cvv = value;
  }

  @action
  void validateCard(String? value) {
    if (value == null || value.isEmpty) {
      error.cardNumber = 'Cannot be blank';
      return;
    }

    if (value.length < 8) {
      error.cardNumber = "Card is invalid";
      return;
    }

    int sum = 0;
    int length = value.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit =
          int.parse(value[length - i - 1]); // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 != 0) {
      error.cardNumber = "Card is invalid";
      return;
    }

    error.cardNumber = null;
  }

  @action
  void validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      error.expirationDate = "This field is required";
      return;
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      error.expirationDate = 'Expiry month is invalid';
      return;
    }

    var fourDigitsYear = CardUtils.convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      error.expirationDate = 'Expiry year is invalid';
      return;
    }
    if (!CardUtils.hasDateExpired(month, year)) {
      error.expirationDate = "Card has expired";
      return;
    }

    error.expirationDate = null;
  }

  @action
  void validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      error.cvv = "This field is required";
      return;
    }
    if (value.length < 3 || value.length > 3) {
      error.cvv = "CVV is invalid";
      return;
    }
    error.cvv = null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  Future<void> createPaymentMethod() async {
    validateCard(cardNumber);
    validateExpiryDate(expirationDate);
    validateCVV(cvv);

    if (!error.hasErrors) {
      debugPrint("Card is $cardNumber");
      debugPrint("CVV is $cvv");

      int month = int.parse(expirationDate!.split('/')[0]);
      int year = int.parse(expirationDate!.split('/')[1]);
      year = CardUtils.convertYearTo4Digits(year);

      PaymentsProvider paymentsProvider = PaymentsProvider();
      try {
        PaymentMethodResponse payment = await paymentsProvider.addPaymentMethod(
            cardNumber!, month, year, cvv!);
        CreditCardModel creditCard = CreditCardModel(
            month: month,
            year: year,
            number: cardNumber!,
            cvv: cvv,
            stripePaymentId: payment.id);
        UserModel? loggedUser = homeStore.loggedUser;
        if (loggedUser != null) {
          bool orderCreated =
              await paymentsProvider.createOrder(loggedUser, creditCard);
          debugPrint("Order: $orderCreated");
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}

class CardErrorState = _CardErrorState with _$CardErrorState;

abstract class _CardErrorState with Store {
  @observable
  String? cardNumber;

  @observable
  String? expirationDate;

  @observable
  String? cvv;

  @computed
  bool get hasErrors =>
      cardNumber != null || expirationDate != null || cvv != null;
}
