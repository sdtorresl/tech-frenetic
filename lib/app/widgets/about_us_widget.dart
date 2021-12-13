import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                color: Theme.of(context).indicatorColor,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Hey, we´re',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Techfrenetic.',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 55),
                child: Column(
                  children: [
                    Text(
                      'Whats the DNA of a Tech Frenetic?',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).indicatorColor,
                          fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'We love to Learn everryday',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'We are tech passionate',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Theme.of(context).indicatorColor,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'We are community lovers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () => Modular.to.pushNamed("/community/"),
                        child: Text(
                          'Become frenetic',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                  color: Theme.of(context).indicatorColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
