import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/widgets/select_avatar_widget.dart';

class ChooseAvatarPage extends StatefulWidget {
  const ChooseAvatarPage({Key? key}) : super(key: key);

  @override
  _ChooseAvatarPageState createState() => _ChooseAvatarPageState();
}

class _ChooseAvatarPageState extends State<ChooseAvatarPage> {
  String selectedAvatar = 'avatar-01';
  bool? useAvatar = true;

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
                      Modular.to.pushNamedAndRemoveUntil(
                          "/community/", (p0) => false);
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
        title: AppLocalizations.of(context)!.say_hi,
        subtitle: AppLocalizations.of(context)!.choose_image,
        destinationRoute: ("/welcome"),
      ),
    );
  }
}
