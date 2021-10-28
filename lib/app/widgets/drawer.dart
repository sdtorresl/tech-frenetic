import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/login/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: GestureDetector(
              child: const Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                        color: Color.fromRGBO(0, 110, 232, 1), width: 1)),
                color: Color.fromRGBO(0, 110, 232, 1),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: GestureDetector(
              child: const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _menuItem(
            context,
            "Tech Community",
            onPressed: () => {debugPrint("Pressed")},
          ),
          _menuItem(
            context,
            "Tech Events",
            onPressed: () => {debugPrint("Pressed")},
          ),
          _menuItem(context, "Tech Vendors",
              onPressed: () => {debugPrint("Pressed")}),
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
      title: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: .5, color: Colors.black),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
          child: GestureDetector(
            onTap: () => onPressed,
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
