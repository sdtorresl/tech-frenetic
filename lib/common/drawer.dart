import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Text('Welcome to ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          fontFamily: 'NunitoSan',
                          color: Color.fromRGBO(5, 20, 47, 1))),
                  Text('Tech Frenetic',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Color.fromRGBO(
                            0,
                            110,
                            232,
                            1,
                          ))),
                ],
              ),
            ),
          ),
          ListTile(
            title: Card(
                color: Color.fromRGBO(
                  0,
                  110,
                  232,
                  1,
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Colors.white),
                  ),
                ))),
            onTap: null,
          ),
          ListTile(
            title: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text('Log in',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'NunitoSan',
                          color: Color.fromRGBO(5, 20, 47, 1)))),
            )),
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.00, color: Colors.black),
                    bottom: BorderSide(width: 1.00, color: Colors.black)),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tech Community',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Color.fromRGBO(5, 20, 47, 1))),
              )),
            ),
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.00, color: Colors.black),
                    bottom: BorderSide(width: 1.00, color: Colors.black)),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tech Events',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Color.fromRGBO(5, 20, 47, 1))),
              )),
            ),
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.00, color: Colors.black),
                    bottom: BorderSide(width: 1.00, color: Colors.black)),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tech Vendors',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontFamily: 'NunitoSan',
                        color: Color.fromRGBO(5, 20, 47, 1))),
              )),
            ),
          ),
          ListTile(
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('About Us',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1))),
            )),
          ),
          ListTile(
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Contact Us',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1))),
            )),
          ),
          ListTile(
            title: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Newsletter',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'NunitoSan',
                      color: Color.fromRGBO(5, 20, 47, 1))),
            )),
          ),
        ],
      ),
    );
  }
}
