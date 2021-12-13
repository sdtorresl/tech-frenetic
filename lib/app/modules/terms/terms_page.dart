import 'package:flutter/material.dart';
import 'package:techfrenetic/app/providers/terms_provider.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    //TermsProvider _termsProvideer = TermsProvider();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
