import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/login/login_page.dart';
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
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: .5, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 23, 0, 13),
                child: GestureDetector(
                  child: const Text(
                    'Tech Community',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: .5, color: Colors.black),
                  bottom: BorderSide(width: .5, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.00),
                child: GestureDetector(
                  child: const Text(
                    'Tech Events',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                  //top: BorderSide(width: .5, color: Colors.black),
                  bottom: BorderSide(width: .5, color: Colors.black),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: GestureDetector(
                  child: const Text('Tech Vendors',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'NunitoSan',
                          color: Color.fromRGBO(5, 20, 47, 1))),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Text('About Us',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Color.fromRGBO(5, 20, 47, 1))),
              ),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          const ListTile(
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Contact Us',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1))),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          const ListTile(
            title: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Newsletter',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontFamily: 'NunitoSan',
                  color: Color.fromRGBO(5, 20, 47, 1),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
