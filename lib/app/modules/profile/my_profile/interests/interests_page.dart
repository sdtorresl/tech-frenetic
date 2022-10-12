import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/models/user_model.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterestsPage extends StatefulWidget {
  final UserModel user;
  const InterestsPage({Key? key, required this.user}) : super(key: key);

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final ProfileStore _profileStore = Modular.get();
  final UserProvider _userProvider = UserProvider();
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  List<CategoriesModel> _availableInterests = [CategoriesModel.empty()];
  late String _selectedInterest;
  final List<CategoriesModel> _userInterests = [];
  bool _isSaving = false;

  @override
  void initState() {
    _loadUserInterests();

    _selectedInterest = _availableInterests.first.id;
    super.initState();
  }

  void _loadUserInterests() {
    _categoriesProvider.getInterests().then((interestsCategories) {
      for (InterestModel interest in widget.user.interests) {
        CategoriesModel interestCategory = interestsCategories
            .firstWhere((element) => element.id == interest.id.toString());
        _userInterests.add(interestCategory);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Column(children: [
          _header(context),
          Expanded(
            child: _certificationsForms(context),
          ),
        ]),
      ),
    );
  }

  Widget _header(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HighlightContainer(
                    child: Text(
                  AppLocalizations.of(context)!.profile_edit_about_blue,
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.primaryColor, fontSize: 25),
                )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.profile_edit_interests,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                )
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Divider(
          color: theme.primaryColor,
          thickness: 1,
        )
      ],
    );
  }

  Widget _certificationsForms(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(
            AppLocalizations.of(context)!.profile_edit_interest,
            style: Theme.of(context).textTheme.headline1,
          ),
          FutureBuilder(
            future: _categoriesProvider.getInterests(),
            initialData: _availableInterests,
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoriesModel>> snapshot) {
              if (snapshot.hasData) {
                _availableInterests = snapshot.data!;

                if (_selectedInterest.isEmpty) {
                  _selectedInterest = _availableInterests.first.id;
                }

                return DropdownButton(
                  isExpanded: true,
                  value: _selectedInterest,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: _availableInterests.map((CategoriesModel item) {
                    return DropdownMenuItem(
                      value: item.id,
                      child: Text(item.category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInterest = newValue!;
                    });
                  },
                );
              } else {
                return DropdownButton(items: const [], onChanged: null);
              }
            },
          ),
          const SizedBox(height: 20),
          HighlightContainer(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profile_edit_add,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ClipOval(
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        splashColor: Theme.of(context).colorScheme.background,
                        onTap: () {
                          if (_selectedInterest.isNotEmpty) {
                            CategoriesModel interest = _availableInterests
                                .firstWhere((e) => _selectedInterest == e.id);

                            if (!_userInterests
                                .any((item) => item.id == interest.id)) {
                              _userInterests.add(interest);
                            }
                            setState(() {});
                          }
                        },
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: _userInterests.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_userInterests[index].category),
                  trailing: IconButton(
                    onPressed: () {
                      _userInterests.removeAt(index);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !_isSaving ? () => _saveCertifications() : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isSaving
                      ? Container(
                          height: 20,
                          width: 40,
                          child: const CircularProgressIndicator(),
                          padding: const EdgeInsets.only(right: 20),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    AppLocalizations.of(context)!.save_changes,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _saveCertifications() async {
    setState(() {
      _isSaving = true;
    });
    await _userProvider.updateInterests(_userInterests);
    setState(() {
      _isSaving = false;
    });
    _profileStore.loggedUser = await _userProvider.getLoggedUser();
    Modular.to.pop();
  }
}
