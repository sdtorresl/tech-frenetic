class CreditCardModel {
  final String? stripePaymentId;
  final String number;
  final String? cvv;
  final int month;
  final int year;

  CreditCardModel({
    this.stripePaymentId,
    this.cvv,
    required this.month,
    required this.year,
    required this.number,
  });
}
