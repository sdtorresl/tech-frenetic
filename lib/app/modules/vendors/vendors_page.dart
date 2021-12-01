import 'package:flutter/material.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class VendorsPage extends StatefulWidget {
  final String title;
  const VendorsPage({Key? key, this.title = 'VendorsPage'}) : super(key: key);
  @override
  VendorsPageState createState() => VendorsPageState();
}

class VendorsPageState extends State<VendorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              paetners(),
              searchByCategory(),
              searchByVendor(),
            ],
          ),
        ],
      ),
    );
  }

  Widget paetners() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Tech Vendors & Partners',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Expand your networking and contact tech Vendors and partners.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search,
                    color: Theme.of(context).unselectedWidgetColor),
                hintText: 'What are you looking for',
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
            const SizedBox(height: 30),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search,
                    color: Theme.of(context).unselectedWidgetColor),
                hintText: 'Where are you from',
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
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    Text(
                      'search',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchByCategory() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    'Serch by',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' Category',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed Pretium Felis Elit Ac varius felis suscipit sed.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => null,
                  child: Text('Applications',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:
                            BorderSide(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => null,
                  child: Text('Cloud',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:
                            BorderSide(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => null,
                  child: Text('Cybersecurity',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:
                            BorderSide(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => null,
                  child: Text('Networking',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:
                            BorderSide(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => null,
                  child: Text('Servers & PCs',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:
                            BorderSide(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => null,
                child: Text('Storage',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                        )),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget searchByVendor() {
    return Container(
      color: Theme.of(context).splashColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    'Search by',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' Vendor',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed Pretium Felis Elit Ac varius felis suscipit sed.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View all vendors ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
