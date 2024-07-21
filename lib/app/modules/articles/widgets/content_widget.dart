import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  final ArticlesStore _articlesStore = Modular.get();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = _articlesStore.content ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 20,
      minLines: 5,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)?.articles_content ?? ''),
      controller: _controller,
      onChanged: _articlesStore.setContent,
    );
  }
}
