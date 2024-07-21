import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/premium/widgets/card_number_store.dart';
import 'package:techfrenetic/app/modules/premium/widgets/card_number_widget.dart';

class CardNumberModule extends WidgetModule {
  CardNumberModule({super.key});

  @override
  List<Bind> get binds => [Bind.singleton((i) => CardNumberStore())];

  @override
  Widget get view => const CardNumberWidget();
}
