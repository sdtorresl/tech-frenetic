import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mobx/mobx.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  final HomeStore _homeStore = Modular.get();
  final String _region = GlobalConfiguration().getValue('cometchat_region');
  final String _appId = GlobalConfiguration().getValue('cometchat_appid');
  final String _key = GlobalConfiguration().getValue('cometchat_key');

  void initialize() async {
    AppSettings appSettings = (AppSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = _region
          ..autoEstablishSocketConnection = true)
        .build();

    CometChat.init(_appId, appSettings, onSuccess: (String successMessage) {
      debugPrint("Initialization completed successfully  $successMessage");
    }, onError: (CometChatException excep) {
      debugPrint("Initialization failed with exception: ${excep.message}");
    });

    final user = await CometChat.getLoggedInUser();
    if (user == null) {
      //TODO: Use the UID
      await CometChat.login("usertest01", _key, onSuccess: (User user) {
        debugPrint("Login Successful : $user");
      }, onError: (CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });
    }

    ConversationsRequest conversationRequest =
        (ConversationsRequestBuilder()..limit = 50).build();
  }
}
