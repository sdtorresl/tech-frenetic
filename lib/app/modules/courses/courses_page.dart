import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/courses/widgets/course_card.dart';
import 'package:techfrenetic/app/modules/premium/premium_page.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';
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
            _isPremium = _isPremium ? _isPremium : snapshot.data!;
            return _isPremium
                ? _premiumUser()
                : PremiumPage(
                    onPremium: () => setState(() {
                      // TODO: Update premium status
                      _isPremium = true;
                    }),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
