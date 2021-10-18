import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _maintitle(context),
          const SizedBox(
            height: 45,
          ),
          _createaccount(context),
          const SizedBox(
            height: 30,
          ),
          _credentialfields(context),
          const SizedBox(
            height: 30,
          ),
          _forgotpassword(context),
          const SizedBox(
            height: 30,
          ),
          _logingbutton(context),
        ],
      ),
    );
  }

  Widget _maintitle(context) {
    return Column(
      children: [
        Text('Login to',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 20, 47, 1),
            )),
        Text('your account',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 50,
                fontFamily: 'NunitoSan',
                color: Color.fromRGBO(0, 110, 232, 1))),
      ],
    );
  }

  Widget _createaccount(context) {
    return Column(
      children: [
        Text('Don´t you have an account yet?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 20, 47, 1),
            )),
        Text('Create one',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                decoration: TextDecoration.underline,
                fontFamily: 'NunitoSan',
                color: Color.fromRGBO(5, 113, 232, 1))),
      ],
    );
  }

  Widget _credentialfields(context) {
    return Column(
      children: [
        Container(
            child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.grey,
            ),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        )),
        SizedBox(height: 30),
        Container(
            child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        )),
      ],
    );
  }

  Widget _forgotpassword(context) {
    return Center(
      child: Text('Forgot your password',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              decoration: TextDecoration.underline,
              fontFamily: 'NunitoSan',
              color: Colors.black)),
    );
  }

  Widget _logingbutton(context) {
    return GestureDetector(
      child: Card(
        color: Color.fromRGBO(0, 110, 232, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Center(
            child: Text('Login',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    fontFamily: 'NunitoSan',
                    color: Colors.white)),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
