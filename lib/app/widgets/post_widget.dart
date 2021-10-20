import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatefulWidget {
  final String title;
  const PostWidget({Key? key, this.title = "PostWidget"}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1.00,
                color: Theme.of(context).unselectedWidgetColor,
              ),
              left: BorderSide(
                width: 0.50,
                color: Colors.grey.withOpacity(.6),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).unselectedWidgetColor,
                spreadRadius: -5,
                blurRadius: 5,
                offset: const Offset(1.9, 1.7),
              )
            ]),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/img/avatars/avatar-02.svg',
                          semanticsLabel: 'Acme Logo',
                        ),
                      ),
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sergio",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 15),
                        ),
                        Text("Profession 1 - 13 days ago",
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text("Hola"),
              ),
              CachedNetworkImage(
                placeholder: (context, value) =>
                    const LinearProgressIndicator(),
                errorWidget: (context, value, e) => const Icon(Icons.error),
                imageUrl:
                    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201810/stockvault-person-studying-and-learning---knowledge-concept178241_0-647x363.jpeg?0LocAW2E2gIBzZp0oZSWzxmQTvAPhN_v&size=1200:675",
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text('territorio',
                    style: Theme.of(context).textTheme.headline4!),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('4 views'),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/img/icons/light_bulb.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Ligth Bulb',
                      ),
                    ),
                    const Text('Cool'),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/img/icons/coment.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Ligth Bulb',
                      ),
                    ),
                    const Text('Comment'),
                    const SizedBox(width: 20),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/img/icons/share.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Ligth Bulb',
                      ),
                    ),
                    const Text('Share'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
