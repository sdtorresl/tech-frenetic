import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class ChooseAvatarPage extends StatefulWidget {
  const ChooseAvatarPage({Key? key}) : super(key: key);

  @override
  _ChooseAvatarPageState createState() => _ChooseAvatarPageState();
}

class _ChooseAvatarPageState extends State<ChooseAvatarPage> {
  bool controlCheck2 = false;
  List checksList = List.filled(2, null);

  @override
  Widget build(BuildContext context) {
    checksList[0] = true;
    List subCheckList = checksList.firstWhere((n) => true);
    if (subCheckList.length == 1) {}
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HighlightContainer(
                  child: Text(
                    'Hi',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).indicatorColor, fontSize: 30),
                  ),
                ),
                Text(
                  'Choose an image',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 20),
                selectAvatarContainer(),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () => Modular.to.pushNamed("/welcome"),
                      child: Text(
                        'Finish',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget selectAvatarContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Choose',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 17),
                    ),
                    Text(
                      'avatar',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 17),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'Upload photo',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 13),
                    ),
                    IconButton(
                      onPressed: () => debugPrint('Im working'),
                      icon: Icon(
                        Icons.add_circle,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            selectAvatar(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget selectAvatar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              'assets/img/avatars/avatar-01.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-02.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-03.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-04.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-05.svg',
              semanticsLabel: 'Acme Logo',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
                value: checksList[0],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      checksList[0] = value;

                      debugPrint(checksList[0].toString());
                    },
                  );
                }),
            Checkbox(
                value: checksList[1],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      checksList[1] = value;

                      debugPrint(checksList.toString());
                    },
                  );
                }),
            Checkbox(
                value: controlCheck2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      controlCheck2 = value!;
                    },
                  );
                }),
            Checkbox(
                value: controlCheck2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      controlCheck2 = value!;
                    },
                  );
                }),
            Checkbox(
                value: controlCheck2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      controlCheck2 = value!;
                    },
                  );
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              'assets/img/avatars/avatar-06.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-07.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-08.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-09.svg',
              semanticsLabel: 'Acme Logo',
            ),
            SvgPicture.asset(
              'assets/img/avatars/avatar-10.svg',
              semanticsLabel: 'Acme Logo',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      value = true;
                    },
                  );
                }),
            Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      value = true;
                    },
                  );
                }),
            Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      value = true;
                    },
                  );
                }),
            Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      value = true;
                    },
                  );
                }),
            Checkbox(
                value: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onChanged: (bool? value) {
                  setState(
                    () {
                      value = true;
                    },
                  );
                }),
          ],
        ),
      ],
    );
  }
}
