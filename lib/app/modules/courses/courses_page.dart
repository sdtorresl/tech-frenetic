import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techfrenetic/app/modules/courses/widgets/course_card.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

import '../../models/courses_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/appbar_widget.dart';

class CoursesPage extends StatefulWidget {
  final String title;
  const CoursesPage({Key? key, this.title = 'Courses'}) : super(key: key);
  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  bool _isPremium = false;
  final UserProvider _userProvider = Modular.get();
  final CoursesProvider _coursesProvider = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Text(
          AppLocalizations.of(context)?.tech_premium ?? '',
          style: Theme.of(context).textTheme.headline3!,
        ),
      ),
      body: FutureBuilder(
        future: _userProvider.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            // _isPremium = snapshot.data!;
            return _isPremium ? _premiumUser() : _nonPremiumUser();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _nonPremiumUser() {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.white,
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(color: theme.backgroundColor),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              _header(theme),
              const SizedBox(
                height: 30,
              ),
              _card(theme)
            ],
          ),
        )
      ],
    );
  }

  Widget _card(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.primaryColorDark),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: theme.primaryColorDark.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(3, 3), // changes position of shadow
            )
          ]),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)?.premium_banner_text ?? '',
              style: theme.textTheme.headline1),
          HighlightContainer(
            child: Text(
              AppLocalizations.of(context)?.premium_banner_tech ?? '',
              style: theme.textTheme.headline1!
                  .copyWith(color: theme.primaryColorDark),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              text: '\$10 ',
              style: theme.textTheme.headline3,
              children: [
                TextSpan(
                  text: "USD " +
                      (AppLocalizations.of(context)?.premium_monthly ?? ''),
                  style: theme.textTheme.bodyLarge,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isPremium = true;
              });
            },
            child: Text(AppLocalizations.of(context)?.premium_start ?? ''),
          ),
          const SizedBox(
            height: 25,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_1 ?? ''),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_2 ?? ''),
          const SizedBox(
            height: 15,
          ),
          _listItem(AppLocalizations.of(context)?.premium_list_3 ?? ''),
        ],
      ),
    );
  }

  Widget _listItem(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).indicatorColor,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _header(ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            HighlightContainer(
              child: Text(
                AppLocalizations.of(context)?.premium_title_premium_span ?? '',
                style: theme.textTheme.headline1!
                    .copyWith(color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              AppLocalizations.of(context)?.premium_title_premium ?? '',
              style: theme.textTheme.headline1!,
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              child: SvgPicture.asset(
                'assets/img/icons/ico_brand.svg',
                height: 65,
                width: 65,
                semanticsLabel: 'TF Logo',
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.tech_frenetic ?? '',
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.colorScheme.primary, fontSize: 30),
                ),
                Text(
                  AppLocalizations.of(context)?.premium_premium ?? '',
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColorDark, fontSize: 28),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _premiumUser() {
    final theme = Theme.of(context);
    return ListView(
      children: [
        _coursesDescription(theme),
        _coursesList(theme),
      ],
    );
  }

  Widget _coursesDescription(ThemeData theme) {
    return Container(
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                AppLocalizations.of(context)?.skills_title ?? '',
                style: theme.textTheme.headline2?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              const Separator(
                separatorWidth: 50,
                height: 2,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
          Text(
            AppLocalizations.of(context)?.courses_subtitle ?? '',
            style: theme.textTheme.headline1
                ?.copyWith(color: Colors.white, fontSize: 26),
          ),
          const SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              text: (AppLocalizations.of(context)?.courses_intro1 ?? '') + ' ',
              style: theme.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)?.courses_intro2 ?? '',
                  style:
                      theme.textTheme.bodyText1?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coursesList(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      color: const Color.fromRGBO(254, 216, 6, 1),
      child: Column(
        children: [
          _courseListTitle(theme),
          RichText(
            text: TextSpan(
              text: (AppLocalizations.of(context)?.courses_intro1 ?? '') + ' ',
              style: theme.textTheme.bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)?.courses_intro2 ?? '',
                  style: theme.textTheme.bodyText1,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _coursesProvider.getCourses(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CourseModel>> snapshot) {
              if (snapshot.hasData) {
                List<CourseModel> courses = snapshot.data!;
                return Column(
                  children: courses
                      .map(
                        (course) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: _courseItem(course),
                        ),
                      )
                      .toList(),
                );
              }
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _courseItem(CourseModel course) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed("/courses/${course.id}"),
      child: CourseCard(
        imageUrl: course.picture,
        headline: course.title,
        subtitle: AppLocalizations.of(context)!.by + (course.owner ?? ''),
      ),
    );
  }

  Widget _courseListTitle(ThemeData theme) {
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 70, top: 10, bottom: 10, right: 15),
          margin: const EdgeInsets.only(top: 15, bottom: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  spreadRadius: 0,
                  blurRadius: 3),
            ],
          ),
          child: Text(
            AppLocalizations.of(context)?.tech_premium ?? '',
            style:
                theme.textTheme.headline1?.copyWith(color: theme.primaryColor),
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(2, 2),
                    spreadRadius: 0,
                    blurRadius: 3),
              ],
            ),
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
