import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/featured_content_widget.dart';
import 'package:techfrenetic/app/widgets/featured_events_widget.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/providers/articles_provider.dart';
import 'package:techfrenetic/app/widgets/latest_contents_widget.dart';
import 'package:techfrenetic/app/widgets/most_popular_widget.dart';
import 'package:techfrenetic/app/widgets/section_header_widget.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final ArticlesProvider _articlesProvideer = ArticlesProvider();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Theme.of(context).buttonTheme.colorScheme!.secondary,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.skills_title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 2.5,
                  width: 60,
                  color: const Color.fromRGBO(255, 204, 54, 1),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.what_do_you,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Aplications',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Cloud',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Cybersecurity',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Networking',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Servers & PCs',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => debugPrint('im working'),
                          child: Text(
                            'Storage',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search,
                        color: Theme.of(context).unselectedWidgetColor),
                    hintText: AppLocalizations.of(context)!.search,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        featuredContent(),
        const FeaturedEventsWidget(),
        leatestContents(),
        mostPopular(),
        contentFrenetics(),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget featuredContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            child: Text(
              AppLocalizations.of(context)!.featured_content,
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
            ),
          ),
          FutureBuilder(
            future: _articlesProvideer.getFeatureArticle(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticlesModel>> snapshot) {
              if (snapshot.hasData) {
                List<ArticlesModel> featureArticles = snapshot.data ?? [];
                List<Widget> featurePost = [];

                for (ArticlesModel article in featureArticles) {
                  featurePost.add(FeaturedArticleWidget(article: article));
                }

                return Column(
                  children: [
                    ...featurePost,
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget leatestContents() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.latest_content,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
          ),
          Container(
            color: Colors.black,
            height: 1.5,
            width: 400,
          ),
          const SizedBox(height: 30),
          FutureBuilder(
            future: _articlesProvideer.getLatestArticle(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticlesModel>> snapshot) {
              if (snapshot.hasData) {
                List<ArticlesModel> latestArticles = snapshot.data ?? [];
                List<Widget> latestPost = [];

                for (ArticlesModel article in latestArticles) {
                  latestPost.add(LatestArticleWidget(article: article));
                }

                return Column(
                  children: [
                    ...latestPost,
                    const SizedBox(height: 30),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget mostPopular() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.most,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.popular,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 30),
            FutureBuilder(
              future: _articlesProvideer.getMostPopular(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ArticlesModel>> snapshot) {
                if (snapshot.hasData) {
                  List<ArticlesModel> latestArticles = snapshot.data ?? [];
                  List<Widget> latestPost = [];
                  int num = 0;

                  for (ArticlesModel article in latestArticles) {
                    num++;
                    latestPost.add(MostPopularWidget(
                      article: article,
                      potition: num,
                    ));
                  }

                  return Column(
                    children: [
                      ...latestPost,
                      const SizedBox(height: 30),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 30),
            Container(
              color: Theme.of(context).unselectedWidgetColor,
              height: .5,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }

  Widget contentFrenetics() {
    return Column(
      children: [
        HighlightContainer(
          child: Text(
            AppLocalizations.of(context)!.tab_content,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Theme.of(context).primaryColor, fontSize: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HighlightContainer(
              child: Text(
                AppLocalizations.of(context)!.from,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 25),
              ),
            ),
            Text(
              'Frenetics',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
            ),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () => Modular.to.pushNamed("/community"),
            child: Text(
              AppLocalizations.of(context)!.explore_more,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).indicatorColor, fontSize: 16),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Theme.of(context).indicatorColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
