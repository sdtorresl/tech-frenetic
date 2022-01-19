import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 300,
                color: Theme.of(context).indicatorColor,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.hey,
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
                      AppLocalizations.of(context)!.about_us_title,
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
                            AppLocalizations.of(context)!.love_to_learn,
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
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context)!.tech_passionate,
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
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context)!.community_lovers,
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
                          AppLocalizations.of(context)!.become,
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
