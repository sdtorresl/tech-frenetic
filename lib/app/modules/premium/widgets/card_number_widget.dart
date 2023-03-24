import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/utils/card_month_input_formatter.dart';
import 'package:techfrenetic/app/core/utils/card_number_input_formatter.dart';
import 'package:techfrenetic/app/modules/premium/widgets/card_number_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/progress_button.dart';

class CardNumberWidget extends StatefulWidget {
  const CardNumberWidget({super.key});

  @override
  State<CardNumberWidget> createState() => _CardNumberWidgetState();
}

class _CardNumberWidgetState extends State<CardNumberWidget> {
  final CardNumberStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Observer(builder: (context) {
            return TextFormField(
              onChanged: store.setCardNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.credit_card),
                hintText: "Card number",
                errorText: store.error.cardNumber,
              ),
            );
          }),
          Row(
            children: [
              Expanded(
                child: Observer(builder: (context) {
                  return TextFormField(
                    onChanged: store.setCVV,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      hintText: "CVV",
                      errorText: store.error.cvv,
                    ),
                  );
                }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Observer(builder: (context) {
                  return TextFormField(
                    onChanged: store.setExpirationMonth,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardMonthInputFormatter()
                    ],
                    decoration: InputDecoration(
                      hintText: "MM/YY",
                      suffixIcon: const Icon(Icons.date_range),
                      errorText: store.error.expirationDate,
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ProgressButton(
            onPressed: store.createPaymentMethod,
            text: AppLocalizations.of(context)?.premium_start ?? '',
          ),
        ],
      ),
    );
  }
}
