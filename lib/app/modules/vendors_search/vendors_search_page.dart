import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/providers/vendors_search_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

class VendorsSearchPage extends StatefulWidget {
  const VendorsSearchPage({Key? key}) : super(key: key);

  @override
  _VendorsSearchPageState createState() => _VendorsSearchPageState();
}

List<String> items = [
  'Order by',
  'Highest category',
  'Lowest category',
  'Name from A- Z',
  'Name from Z- A',
];
String? defaultValue = items.first;

class _VendorsSearchPageState extends State<VendorsSearchPage> {
  @override
  Widget build(BuildContext context) {
    VendorsSearchProvider searchProvider = VendorsSearchProvider();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        backgroundColor: Colors.white,
        title: Text(
          'Result',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HighlightContainer(
                      child: Text(
                        'Tech Vendors',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 25,
                              color: Theme.of(context).indicatorColor,
                            ),
                      ),
                    ),
                    Text(
                      ' & Partners',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      bottom: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      left: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      right: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What are you looking for',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 12),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Write the area,service or provider',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).hintColor),
                          //errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      bottom: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      left: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                      right: BorderSide(
                        width: 0.50,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(.3),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Where',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 12),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Write the city or location',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).hintColor),
                          //errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => debugPrint('Im working'),
                    child: const Text('search'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorDark),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FutureBuilder(
                  future: searchProvider.getVendorWall(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return searchResults(snapshot.data);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchResults(WallModel wall) {
    String results = wall.results;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search results',
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 19),
            ),
            Text(
              '$results results',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 17,
                    color: Theme.of(context).indicatorColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 0.50,
                color: Theme.of(context).unselectedWidgetColor.withOpacity(.3),
              ),
              bottom: BorderSide(
                width: 0.50,
                color: Theme.of(context).unselectedWidgetColor.withOpacity(.3),
              ),
              left: BorderSide(
                width: 0.50,
                color: Theme.of(context).unselectedWidgetColor.withOpacity(.3),
              ),
              right: BorderSide(
                width: 0.50,
                color: Theme.of(context).unselectedWidgetColor.withOpacity(.3),
              ),
            ),
          ),
          child: DropdownButton<String>(
            value: defaultValue,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text(
              'Your profession',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
            ),
            items: items.map(
              (String valueItem) {
                return DropdownMenuItem<String>(
                  child: Text(valueItem),
                  value: valueItem,
                );
              },
            ).toList(),
            onChanged: (newValue) {
              setState(
                () {
                  defaultValue = newValue;
                  debugPrint(defaultValue);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: () => debugPrint('Im working'),
            child: const Text('Filter'),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
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
