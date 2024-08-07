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
  TextEditingController conversationSearchController = TextEditingController();
  @observable
  TextEditingController messageEditingController = TextEditingController();
  @observable
  TextEditingController filterEditingController = TextEditingController();
  @observable
  TextEditingController groupsSearchEditingController = TextEditingController();
  @observable
  User? loggedUser;
  @observable
  var users = ObservableList<User>.of([]);
  @observable
  var conversations = ObservableList<Conversation>.of([]);
  @observable
  var groups = ObservableList<Group>.of([]);
  @observable
  var messages = ObservableList<BaseMessage>.of([]);

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

    loggedUser = await CometChat.getLoggedInUser();
    if (loggedUser == null) {
      //TODO: Use the UID
      await CometChat.login("superhero2", _key, onSuccess: (User? user) {
        debugPrint("Login Successful : $user");
        loggedUser = user;
      }, onError: (CometChatException e) {
        debugPrint("Login failed with exception:  ${e.message}");
      });
    }

    filterEditingController.addListener(() {
      getUsers();
    });

    groupsSearchEditingController.addListener(() {
      getGroups();
    });

    conversationSearchController.addListener(() {
      getConversations();
    });
  }

  void getUsers() async {
    loading = true;
    final usersRequestBuilder = UsersRequestBuilder()
      ..limit = 50
      ..friendsOnly = false;

    if (filterEditingController.text.isNotEmpty) {
      usersRequestBuilder.searchKeyword = filterEditingController.text;
    }

    final UsersRequest usersRequest = usersRequestBuilder.build();
    usersRequest.fetchNext(onSuccess: (List<User> users) {
      this.users = ObservableList<User>.of(users);
      loading = false;
    }, onError: (error) {
      loading = false;
      throw error;
    });
  }

  void getGroups() async {
    loading = true;
    final groupsRequestBuilder = GroupsRequestBuilder()
      ..limit = 50
      ..joinedOnly = true;

    if (groupsSearchEditingController.text.isNotEmpty) {
      groupsRequestBuilder.searchKeyword = groupsSearchEditingController.text;
    }

    final GroupsRequest usersRequest = groupsRequestBuilder.build();
    usersRequest.fetchNext(
        onSuccess: (List<Group> groups) {
          this.groups = ObservableList<Group>.of(groups);
          loading = false;
        },
        onError: (error) => throw error);
  }

  void getConversations() async {
    loading = true;
    final ConversationsRequest _conversationRequest =
        (ConversationsRequestBuilder()..limit = 50).build();

    _conversationRequest.fetchNext(
        onSuccess: (List<Conversation> conversations) {
          this.conversations = ObservableList<Conversation>.of(conversations
              .where((c) => conversationMatchFilter(c.conversationWith)));
          loading = false;
        },
        onError: (error) => throw error);
  }

  void getMessages(String id, {bool groupMessages = false}) async {
    //loading = true;

    MessagesRequestBuilder messageRequestBuilder = MessagesRequestBuilder()
      ..limit = 50
      ..messageId = -1;

    if (groupMessages) {
      messageRequestBuilder.guid = id;
    } else {
      messageRequestBuilder.uid = id;
    }

    MessagesRequest messageRequest = messageRequestBuilder.build();

    messageRequest.fetchNext(
        onSuccess: (List<BaseMessage> list) {
          for (BaseMessage message in list) {
            if (message is TextMessage) {
              messages = ObservableList.of(list);
              debugPrint("Text message received successfully: " +
                  (message).toString());
            } else if (message is MediaMessage) {
              debugPrint("Media message received successfully: " +
                  (message).toString());
            }
          }
          loading = false;
        },
        onError: (error) => throw error);
  }

  void sendMessage({
    required String receiverID,
    String receiverType = CometChatConversationType.user,
    String type = CometChatMessageType.text,
  }) {
    TextMessage textMessage = TextMessage(
        text: messageEditingController.text,
        receiverUid: receiverID,
        receiverType: receiverType,
        type: type);

    CometChat.sendMessage(textMessage, onSuccess: (TextMessage message) {
      debugPrint("Message sent successfully:  $message");
      messages.add(message);
      messageEditingController.text = '';
    }, onError: (CometChatException e) {
      debugPrint("Message sending failed with exception:  ${e.message}");
    });
  }

  bool conversationMatchFilter(AppEntity entity) {
    if (entity is User) {
      return entity.name
          .contains(conversationSearchController.text.toLowerCase());
    }
    return (entity as Group)
        .name
        .contains(conversationSearchController.text.toLowerCase());
  }
}
