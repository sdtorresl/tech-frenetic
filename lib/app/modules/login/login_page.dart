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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SafeArea(
              child: SizedBox(
                height: 50,
              ),
            ),
            _mainTitle(context),
            const SizedBox(
              height: 45,
            ),
            _createAccount(context),
            const SizedBox(
              height: 30,
            ),
            _loginForm(context),
            const SizedBox(
              height: 30,
            ),
            _forgotPassword(context),
            const SizedBox(
              height: 30,
            ),
            _logginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _mainTitle(context) {
    return Column(
      children: const [
        Text('Login to',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              fontFamily: 'NunitoSan',
              color: Color.fromRGBO(5, 20, 47, 1),
            )),
        Text(
          'your account',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 50,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(0, 110, 232, 1),
          ),
        ),
      ],
    );
  }

  Widget _createAccount(context) {
    return Column(
      children: const [
        Text(
          'Don´t you have an account yet?',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(5, 20, 47, 1),
          ),
        ),
        Text(
          'Create one',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontFamily: 'NunitoSan',
            color: Color.fromRGBO(5, 113, 232, 1),
          ),
        ),
      ],
    );
  }

  Widget _loginForm(context) {
    return Column(
      children: const [
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.grey,
            ),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return const Center(
      child: Text(
        'Forgot your password',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontFamily: 'NunitoSan',
            color: Colors.black),
      ),
    );
  }

  Widget _logginButton(context) {
    return GestureDetector(
      child: const Card(
        color: Color.fromRGBO(0, 110, 232, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Center(
            child: Text(
              'Login',
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
    );
  }
}
