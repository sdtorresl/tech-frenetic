import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/common/alert_dialog.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ListTile(
              title: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/img/icons/ico_brand.svg',
                    height: 50,
                    width: 50,
                    semanticsLabel: 'TF Logo',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _menuItem(
            context,
            "Tech Community",
            onPressed: () => Modular.to.popAndPushNamed("/community"),
          ),
          _menuItem(
            context,
            "Tech Events",
            onPressed: () => {
              Modular.to.popAndPushNamed("/events"),
            },
          ),
          _menuItem(
            context,
            "Tech Vendors",
            onPressed: () => {
              debugPrint("Pressed vendors"),
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _simpleMenuItem(context, "About Us",
              onPressed: () => {Modular.to.popAndPushNamed("/about_us")}),
          _simpleMenuItem(context, "Contact Us",
              onPressed: () => {Modular.to.popAndPushNamed("/contact_us")}),
          _simpleMenuItem(context, "Newsletter",
              onPressed: () => {debugPrint("Newsletter us pressed")}),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.logout_button),
                ],
              ),
              onPressed: () async {
                UserProvider userProvider = UserProvider();
                if (await userProvider.logout()) {
                  Modular.to.pushReplacementNamed("/login");
                } else {
                  showMessage(
                    context,
                    title: AppLocalizations.of(context)!.error,
                    content: Text(AppLocalizations.of(context)!.error_logout),
                    actions: <Widget>[
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Modular.to.pushReplacementNamed("/login");
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, String text,
      {required void Function() onPressed}) {
    return ListTile(
      onTap: onPressed,
      title: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: .5, color: Colors.black),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 20, 47, 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _simpleMenuItem(BuildContext context, String text,
      {required void Function() onPressed}) {
    return ListTile(
      onTap: onPressed,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
