import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'messaging_store.g.dart';

class MessagingStore = _ChatStoreBase with _$MessagingStore;

abstract class _ChatStoreBase with Store, MessageListener, UserListener {
  @observable
  String? activeUid;
  @observable
  String? status;
  @observable
  bool loading = false;
  @observable
  TextEditingController messageEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @observable
  var messages = ObservableList<BaseMessage>.of([]);

  @action
  void addMessage(BaseMessage message) {
    messages.add(message);
    _scrollToBottom();
  }

  @action
  setLoading(bool value) => loading = value;

  @action
  Future<void> getMessages(AppEntity entity) async {
    setLoading(true);
    activeUid = entity is User ? entity.uid : (entity as Group).guid;
    MessagesRequestBuilder messageRequestBuilder = MessagesRequestBuilder()
      ..limit = 50;

    if (entity is Group) {
      messageRequestBuilder.guid = activeUid;
    } else {
      messageRequestBuilder.uid = activeUid;
    }

    MessagesRequest messageRequest = messageRequestBuilder.build();

    await messageRequest.fetchPrevious(
        onSuccess: (List<BaseMessage> list) {
          messages = ObservableList<BaseMessage>.of(list);
          setLoading(false);
          _scrollToBottom();
        },
        onError: (error) => throw error);
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void initializeListeners(AppEntity entity) {
    activeUid = entity is User ? entity.uid : (entity as Group).guid;

    CometChat.addMessageListener(activeUid!, this);
    CometChat.addUserListener(activeUid!, this);
  }

  void sendMessage({
    required String receiverID,
    String receiverType = CometChatConversationType.user,
    String type = CometChatMessageType.text,
  }) {
    if (messageEditingController.text.isEmpty) return;

    TextMessage textMessage = TextMessage(
        text: messageEditingController.text,
        receiverUid: receiverID,
        receiverType: receiverType,
        type: type);

    CometChat.sendMessage(textMessage, onSuccess: (TextMessage message) {
      debugPrint("Message sent successfully:  ${message.text}");
      addMessage(message);
      debugPrint(messages.toString());
      messageEditingController.text = '';
    }, onError: (CometChatException e) {
      debugPrint("Message sending failed with exception:  ${e.message}");
    });
  }

  @override
  void onTextMessageReceived(TextMessage textMessage) {
    debugPrint(
        "Text message received successfully: ${textMessage.conversationId}");

    CometChat.getConversationFromMessage(
      textMessage,
      onSuccess: (conversation) {
        switch (conversation.conversationType) {
          case ConversationType.group:
            if (activeUid == (conversation.conversationWith as Group).guid) {
              addMessage(textMessage);
            }
            break;
          case ConversationType.user:
            if (activeUid == (conversation.conversationWith as User).uid) {
              addMessage(textMessage);
            }
            break;
        }
      },
      onError: (error) => {
        debugPrint("Error while converting message object $error"),
      },
    );
  }

  @override
  void onMediaMessageReceived(MediaMessage mediaMessage) {
    debugPrint("Media message received successfully: $mediaMessage");
  }

  @override
  void onCustomMessageReceived(CustomMessage customMessage) {
    debugPrint("Custom message received successfully: $customMessage");
  }

  @override
  void onUserOnline(User user) {
    debugPrint("User ${user.uid} is now online");
    if (activeUid == user.uid) {
      status = "Online";
    }
  }

  @override
  void onUserOffline(User user) {
    debugPrint("User ${user.uid} is now offline");
    if (activeUid == user.uid) {
      status = "Offline";
    }
  }
}
