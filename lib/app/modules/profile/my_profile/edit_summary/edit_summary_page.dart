import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/errors.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/edit_summary/edit_summary_store.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSummaryPage extends StatefulWidget {
  const EditSummaryPage({Key? key}) : super(key: key);

  @override
  _EditSummaryPageState createState() => _EditSummaryPageState();
}

class _EditSummaryPageState extends State<EditSummaryPage> {
  final SummaryStore _summaryStore = SummaryStore();
  final TextEditingController _controller = TextEditingController();
  final UserProvider _userProvider = UserProvider();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _summaryStore.setupValidations();
    _userProvider.getLoggedUser().then((loggedUser) {
      _controller.text = loggedUser != null ? loggedUser.biography : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Column(children: [
          _header(context),
          Expanded(
            child: _articleForm(context),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _summaryStore.dispose();
    super.dispose();
  }

  Widget _header(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HighlightContainer(
                    child: Text(
                  AppLocalizations.of(context)!.profile_edit_about_blue,
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.profile_edit_about,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                )
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Divider(
          color: theme.primaryColor,
          thickness: 1,
        )
      ],
    );
  }

  Widget _articleForm(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          const SizedBox(height: 60),
          Observer(
            builder: (context) => TextFormField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 20,
              decoration: InputDecoration(
                hintText: '',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).hintColor),
                errorText: TFError.getError(context, _summaryStore.error),
                errorStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
              onChanged: (value) => _summaryStore.summary = value,
            ),
          ),
          const SizedBox(height: 60),
          Observer(
            builder: (context) => ElevatedButton(
                onPressed: _summaryStore.hasErrors || _isLoading
                    ? null
                    : () => _updateBiografy(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _isLoading
                        ? Container(
                            height: 20,
                            width: 20,
                            margin: const EdgeInsets.only(right: 20),
                            child: const CircularProgressIndicator(
                                color: Colors.white),
                          )
                        : const SizedBox(),
                    Text(AppLocalizations.of(context)!.save_changes),
                  ],
                )),
          )
        ],
      ),
    );
  }

  void _updateBiografy() async {
    setState(() {
      _isLoading = true;
    });
    bool updated = await _summaryStore.updateBiografy();

    setState(() {
      _isLoading = false;
    });

    String message = updated
        ? AppLocalizations.of(context)!.mssage_success
        : AppLocalizations.of(context)!.error;

    SnackBar snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Modular.to.pop();
  }
}
