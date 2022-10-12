import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/providers/followers_provider.dart';
import 'package:techfrenetic/app/widgets/progress_button_widget.dart';

class FollowButtonWidget extends StatefulWidget {
  final int targetUserId;

  const FollowButtonWidget({Key? key, required this.targetUserId})
      : super(key: key);

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  bool _isFollowingUser = false;
  final FollowersProvider _followersProvider = FollowersProvider();
  final UserPreferences _prefs = UserPreferences();
  late final int _currentUser = int.parse(_prefs.userId!);
  late final int _targetUser = widget.targetUserId;

  @override
  void initState() {
    super.initState();
    _followersProvider.isFollowing(_currentUser, _targetUser).then((value) {
      setState(() {
        _isFollowingUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressButtonWidget(
      onPressed: () => _isFollowingUser ? _unfollowUser() : _followUser(),
      child: _isFollowingUser
          ? Text(AppLocalizations.of(context)!.profile_unfollow)
          : Text(AppLocalizations.of(context)!.profile_follow),
    );
  }

  _followUser() async {
    debugPrint("Follow user ");

    bool result =
        await _followersProvider.addFollower(_currentUser, _targetUser);
    setState(() {
      _isFollowingUser = result;
    });
  }

  _unfollowUser() async {
    debugPrint("Unfollow");
    bool result =
        await _followersProvider.removeFollower(_currentUser, _targetUser);
    setState(() {
      _isFollowingUser = !result;
    });
  }
}
