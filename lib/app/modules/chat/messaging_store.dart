import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'messaging_store.g.dart';

class MessagingStore = _ChatStoreBase with _$MessagingStore;

abstract class _ChatStoreBase with Store, MessageListener {
  @observable
  bool loading = false;
  @observable
  TextEditingController messageEditingController = TextEditingController();
  @observable
  var messages = ObservableList<BaseMessage>.of([]);

  @action
  void addMessage(BaseMessage message) => messages.add(message);

  @action
  setLoading(bool value) => loading = value;

  @action
  Future<void> getMessages(String id, {bool groupMessages = false}) async {
    setLoading(true);

    MessagesRequestBuilder messageRequestBuilder = MessagesRequestBuilder()
      ..limit = 50;

    if (groupMessages) {
      messageRequestBuilder.guid = id;
    } else {
      messageRequestBuilder.uid = id;
    }

    MessagesRequest messageRequest = messageRequestBuilder.build();

    await messageRequest.fetchPrevious(
        onSuccess: (List<BaseMessage> list) {
          messages = ObservableList<BaseMessage>.of(list);

          setLoading(false);
        },
        onError: (error) => throw error);
  }

  void initializeListeners() {
    CometChat.addMessageListener("listenerId", this);
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
      onSuccess: (conversation) => {
        debugPrint("Conversation Object $conversation"),
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
}
