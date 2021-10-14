import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/login/login_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            child: Image.asset('assets/img/main-logo.png'),
          ),
          DrawerHeader(
            child: Center(
              child: Column(
                children: const [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1),
                    ),
                  ),
                  Text(
                    'Tech Frenetic',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Color.fromRGBO(0, 110, 232, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: GestureDetector(
              child: const Card(
                shape: StadiumBorder(
                    side: BorderSide(
                        color: Color.fromRGBO(0, 110, 232, 1), width: 1)),
                color: Color.fromRGBO(0, 110, 232, 1),
                child: Center(
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
            ),
            onTap: () {},
          ),
          ListTile(
            title: GestureDetector(
              child: const Card(
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.black, width: 1)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
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
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: .5, color: Colors.black),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
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
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: .5, color: Colors.black),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
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
          ),
          ListTile(
            title: Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: .5, color: Colors.black),
                    bottom: BorderSide(width: .5, color: Colors.black)),
              ),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(30.0),
                child: GestureDetector(
                  child: const Text('Tech Vendors',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'NunitoSan',
                          color: Color.fromRGBO(5, 20, 47, 1))),
                ),
              )),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
          ),
          const SizedBox(
            height: 40,
          ),
          const ListTile(
            title: Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Contact Us',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1))),
            )),
          ),
          const SizedBox(
            height: 40,
          ),
          const ListTile(
            title: Center(
              child: Padding(
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
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
