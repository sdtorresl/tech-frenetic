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

  @observable
  bool loading = false;
  @observable
  var users = ObservableList<User>.of([]);
  @observable
  var conversations = ObservableList<Conversation>.of([]);
  @observable
  var groups = ObservableList<Group>.of([]);

  final ConversationsRequest _conversationRequest =
      (ConversationsRequestBuilder()..limit = 50).build();
  final UsersRequest _usersRequest = (UsersRequestBuilder()
        ..limit = 50
        ..friendsOnly = false)
      .build();

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
      await CometChat.login("superhero1", _key, onSuccess: (User? user) {
        debugPrint("Login Successful : $user");
      }, onError: (CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });
    }
  }

  void getUsers() async {
    loading = true;
    _usersRequest.fetchNext(
        onSuccess: (List<User> users) {
          this.users.addAll(users);
          loading = false;
        },
        onError: (error) => throw error);
  }

  void getConversations() async {
    loading = true;
    _conversationRequest.fetchNext(
        onSuccess: (List<Conversation> conversations) {
          conversations.addAll(conversations);
          loading = false;
        },
        onError: (error) => throw error);
  }
}
