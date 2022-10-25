import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final HomeStore homeStore = Modular.get();

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
            AppLocalizations.of(context)!.tech_community,
            onPressed: () {
              homeStore.selectedPage = 0;
              Modular.to.popAndPushNamed('/community');
            },
          ),
          _menuItem(
            context,
            AppLocalizations.of(context)!.tech_events,
            onPressed: () => Modular.to.popAndPushNamed("/events"),
          ),
          _menuItem(
            context,
            AppLocalizations.of(context)!.tech_vendors,
            onPressed: () {
              homeStore.selectedPage = 2;
              Modular.to.popAndPushNamed('/vendors');
            },
          ),
          const SizedBox(
            height: 30,
          ),
          _simpleMenuItem(
            context,
            AppLocalizations.of(context)!.contact,
            onPressed: () => Modular.to.popAndPushNamed("/contact_us"),
          ),
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
                await userProvider.logout();
                Modular.to.pushNamedAndRemoveUntil(
                    "/login", ModalRoute.withName("/login"));
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
