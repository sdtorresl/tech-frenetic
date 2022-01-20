import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/providers/registration_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/select_avatar_widget.dart';

class EditAvatarPage extends StatefulWidget {
  const EditAvatarPage({Key? key}) : super(key: key);

  @override
  _EditAvatarPageState createState() => _EditAvatarPageState();
}

class _EditAvatarPageState extends State<EditAvatarPage> {
  String selectedAvatar = 'avatar-01';
  bool? useAvatar = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
                      Navigator.of(context).pop();
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
                      Modular.to
                          .pushNamedAndRemoveUntil("/profile/", (p0) => false);
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
      ),
      body: SelectAvatarWidget(
        title1: AppLocalizations.of(context)!.say_hi,
        title2: AppLocalizations.of(context)!.change_avatar,
      ),
    );
  }
}
