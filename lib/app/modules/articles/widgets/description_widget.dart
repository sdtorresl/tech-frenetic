import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  final ArticlesStore _articlesStore = Modular.get();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = _articlesStore.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)?.articles_description ?? ''),
      controller: _controller,
      onChanged: _articlesStore.setDescription,
    );
  }
}
