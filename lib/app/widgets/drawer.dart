import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          ListTile(
            title: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.about),
                ],
              ),
              onPressed: () => debugPrint("Pressed"),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // background
                onPrimary: Colors.black, // foreground
                elevation: 0,
                side: const BorderSide(width: 1.5, color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.login_title),
                ],
              ),
              onPressed: () => Modular.to.pushNamed("/login"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _menuItem(
            context,
            "Tech Community",
            onPressed: () => {
              debugPrint("Pressed TC"),
            },
          ),
          _menuItem(
            context,
            "Tech Events",
            onPressed: () => {
              debugPrint("Pressed events"),
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
              onPressed: () => {debugPrint("About us pressed")}),
          _simpleMenuItem(context, "Contact Us",
              onPressed: () => {debugPrint("Contact us pressed")}),
          _simpleMenuItem(context, "Newsletter",
              onPressed: () => {debugPrint("Newsletter us pressed")}),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, String text,
      {required Function onPressed}) {
    return ListTile(
      onTap: () => onPressed,
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
      {required Function onPressed}) {
    return ListTile(
      onTap: () => onPressed,
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
