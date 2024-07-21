import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/select_avatar_widget.dart';

class EditAvatarPage extends StatelessWidget {
  EditAvatarPage({Key? key}) : super(key: key);
  final HomeStore _homeStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        onPressed: () {
          Widget content = Text(AppLocalizations.of(context)!.avatar_message);
          List<Widget> actions = [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.cancel.toUpperCase(),
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!
                        .message_btn_later
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Modular.to.pushNamedAndRemoveUntil(
                        "/profile/profile", (p0) => false);
                  },
                ),
              ],
            ),
          ];
          showMessage(context,
              title: AppLocalizations.of(context)!.message.toUpperCase(),
              content: content,
              actions: actions);
        },
      ),
      body: SelectAvatarWidget(
        title: AppLocalizations.of(context)!.say_hi,
        subtitle: AppLocalizations.of(context)!.change_avatar,
        defaultAvatar: _homeStore.loggedUser?.avatar ?? "avatar-01",
      ),
    );
  }
}
