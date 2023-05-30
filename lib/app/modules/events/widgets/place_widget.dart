import 'package:flutter/material.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: const Color(0xFF0A3991),
      padding: const EdgeInsets.only(left: 40.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: SizedBox(
                    width: 19,
                    height: 19,
                    child: Container(
                      color: const Color.fromARGB(255, 245, 249, 255),
                    )),
              ),
              Text("Nearest event",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      )),
            ],
          ),
          Text("Cybersecurity Congress 2023",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: const Color.fromARGB(255, 0, 128, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  )),
          Row(
            children: [
              const Icon(
                color: Colors.white,
                Icons.place_outlined,
                size: 40,
              ),
              const SizedBox(width: 20),
              Text("Madrid, Spain",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      )),
            ],
          ),
          Row(
            children: [
              const Icon(
                color: Colors.white,
                Icons.calendar_month_outlined,
                size: 40,
              ),
              const SizedBox(width: 20),
              Text("Apr. 30, 2023",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {},
                  child: Text("Learn more",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 1),
                  )),
              OutlinedButton(
                  onPressed: () {},
                  child: Text("Buy tickets",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 1),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
