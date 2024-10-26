import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/features/chats/bloc/chats_bloc.dart';
import 'package:bibinto/src/features/chats/model/dialog_model.dart';
import 'package:bibinto/src/features/chats/model/message_model.dart';
import 'package:bibinto/src/features/profile/data/repository/profile_repository.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatScreenInProfile extends StatelessWidget {
  const ChatScreenInProfile({
    super.key,
    required this.title,
    required this.userId,
  });

  final String title;
  final int userId;

  @override
  Widget build(BuildContext context) {
    DialogModel? dialog;

    return Scaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backButton(context),
            ],
          ),
        ),
        title: title,
      ),
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          switch (state) {
            case ChatsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ChatLoaded():
              dialog = state.dialog;
              return Chat(
                userId: userId,
                dialog: state.dialog,
                title: title,
              );
            case ChatsFailure():
              return Chat(
                userId: userId,
                dialog: dialog,
                title: title,
              );
          }
          return Chat(
            userId: userId,
            dialog: dialog,
            title: title,
          );
        },
      ),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.title,
    required this.userId,
    required this.dialog,
  });

  final String title;
  final int userId;
  final DialogModel? dialog;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  final chatRepository = ProfileRepository();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      BlocProvider.of<ChatsBloc>(context).add(
        SendMessageEvent(messageController.text.trim(), widget.userId,
            widget.dialog?.id ?? 0),
      );
      messageController.clear();
    }
  }

  void addMessageIfNotExists(MessageModel message) {
    if (widget.dialog?.messages.contains(message) == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (widget.dialog?.messages.contains(message) == false) {
            widget.dialog?.messages.add(message);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.dialog?.messages.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    return BlocListener<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state is ChatsFailure) {
          showCustomErrorNotification(
            context,
            'Невозможно отправить сообщение',
            'Вы не подписаны друг на друга',
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          child: widget.dialog?.messages.isNotEmpty ?? false
              ? messageList(context)
              : messageList(context),
        ),
      ),
    );
  }

  Column messageList(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Subscription(
            options: SubscriptionOptions(document: chatRepository.streamDoc),
            builder: (QueryResult<Object?> result) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return ListMessages(widget: widget);
              }

              var messagesJson =
                  result.data?['allDialogsUpdates']?['newMessage'];
              if (messagesJson != null) {
                var messages = MessageModel.fromJson(messagesJson);
                addMessageIfNotExists(messages);
              }

              return ListMessages(widget: widget);
            },
          ),
        ),
        Container(
          height: 73,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Color.fromRGBO(242, 242, 247, 1),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: messageController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text(
                          Localized.of(context).enterMessage,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(118, 118, 140, 1),
                          ),
                        ),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: const TextStyle(fontSize: 0),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromRGBO(242, 242, 247, 1),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    sendMessage();
                  },
                  child: ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(24, 119, 242, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/sendIcon.svg',
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ListMessages extends StatelessWidget {
  const ListMessages({
    super.key,
    required this.widget,
  });

  final Chat widget;

  @override
  Widget build(BuildContext context) {
    final messages = widget.dialog?.messages ?? [];

    if (messages.isEmpty) {
      return Center(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/Chats.svg'),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 310,
                child: Text(
                  Localized.of(context).startMeet(widget.title),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color.fromRGBO(118, 118, 140, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index].payload;
        final bool isMyMessage = messages[index].user?.isMe ?? false;

        return Column(
          crossAxisAlignment:
              isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: isMyMessage
                    ? const Color.fromRGBO(24, 119, 242, 1)
                    : const Color.fromRGBO(242, 242, 247, 1),
                borderRadius: isMyMessage
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(4),
                        bottomLeft: Radius.circular(16),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: isMyMessage
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(31, 31, 44, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget editAndSendMessage({
  required BuildContext context,
  required Function sendMessage,
}) {
  return Container(
    height: 73,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        border: Border(
            top:
                BorderSide(width: 1, color: Color.fromRGBO(242, 242, 247, 1)))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  label: Text(
                    Localized.of(context).enterMessage,
                    style: const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color.fromRGBO(118, 118, 140, 1),
                    ),
                  ),
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  errorStyle: const TextStyle(fontSize: 0),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: const Color.fromRGBO(242, 242, 247, 1),
                  filled: true,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              sendMessage();
            },
            child: ClipOval(
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(24, 119, 242, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/sendIcon.svg',
                  height: 26,
                  width: 26,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
