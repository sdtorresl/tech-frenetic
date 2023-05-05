import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'chat_users_store.g.dart';

class ChatUsersStore = _ChatStoreBase with _$ChatUsersStore;

abstract class _ChatStoreBase with Store {
  @observable
  bool loading = false;
  @observable
  TextEditingController messageEditingController = TextEditingController();

  var messages = ObservableList<BaseMessage>.of([]);

  void initialize(String id, {bool groupMessages = false}) async {
    loading = true;

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
}
