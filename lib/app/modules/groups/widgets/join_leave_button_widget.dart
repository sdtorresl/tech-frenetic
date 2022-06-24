import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/user_preferences.dart';
import 'package:techfrenetic/app/models/group_model.dart';
import 'package:techfrenetic/app/providers/group_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JoinLeaveButtonWidget extends StatefulWidget {
  final GroupModel group;

  const JoinLeaveButtonWidget({Key? key, required this.group})
      : super(key: key);

  @override
  State<JoinLeaveButtonWidget> createState() => _JoinLeaveButtonWidgetState();
}

class _JoinLeaveButtonWidgetState extends State<JoinLeaveButtonWidget> {
  final UserPreferences _userPreferences = UserPreferences();
  final GroupsProvider _groupsProvider = GroupsProvider();
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? userId = _userPreferences.userId;
    if (userId != null) {
      return FutureBuilder(
        future: _groupsProvider.getUserIdInGroup(userId, widget.group.id),
        builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
          int? gUserId = snapshot.data;
          if (gUserId == null) {
            return _joinButton(userId);
          } else {
            return _leaveButton(gUserId);
          }
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _joinButton(String userId) {
    return ElevatedButton(
      onPressed: () async {
        debugPrint("Join group!");
        setState(() {
          _isLoading = true;
        });
        bool joined =
            await _groupsProvider.joinGroup(userId.toString(), widget.group.id);
        if (joined) {
          debugPrint("Joined!");
        }
        setState(() {
          _isLoading = false;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 20),
                  child: const CircularProgressIndicator(color: Colors.white),
                )
              : const SizedBox(),
          Text(
            widget.group.public
                ? AppLocalizations.of(context)!.btn_join
                : AppLocalizations.of(context)!.groups_btn_join_request,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }

  Widget _leaveButton(int gUserId) {
    return ElevatedButton(
      onPressed: () async {
        debugPrint("Leave group!");
        setState(() {
          _isLoading = true;
        });
        bool leaved = await _groupsProvider.leaveGroup(
            gUserId.toString(), widget.group.id);
        if (leaved) {
          debugPrint("Leaved!");
        }
        setState(() {
          _isLoading = false;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 20),
                  child: const CircularProgressIndicator(color: Colors.white),
                )
              : const SizedBox(),
          Text(
            AppLocalizations.of(context)!.btn_leave,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
