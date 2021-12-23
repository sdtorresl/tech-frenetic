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
  String selectedAvatar = 'avatar-01';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                _nextStep(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _nextStep(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: ElevatedButton(
          onPressed: () =>
              Modular.to.pushNamed("/welcome", arguments: selectedAvatar),
          child: Text(
            'Finish',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          ),
        ),
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
    List<String> avatars = [
      'avatar-01',
      'avatar-02',
      'avatar-03',
      'avatar-04',
      'avatar-05',
      'avatar-06',
      'avatar-07',
      'avatar-08',
      'avatar-09',
      'avatar-10',
    ];

    List<Widget> avatarWidgets = avatars
        .map((avatar) => singleAvatar(avatar, avatar == selectedAvatar))
        .toList();
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 10,
      runSpacing: 10,
      children: avatarWidgets,
    );
  }

  Widget singleAvatar(String avatar, bool checked) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/img/avatars/$avatar.svg",
        ),
        Checkbox(
          value: checked,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onChanged: (bool? value) {
            setState(
              () {
                if (value = true) {
                  selectedAvatar = avatar;
                  debugPrint(selectedAvatar);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
