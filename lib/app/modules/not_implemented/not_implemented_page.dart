import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class NotImplementedPage extends StatelessWidget {
  const NotImplementedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        onPressed: () => Modular.to.pop(),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Text(
                "Sorry, this page is still under construction",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25),
              ),
            ),
            Image.asset(
              'assets/img/not-found.png',
              fit: BoxFit.fitHeight,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
