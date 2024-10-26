import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/chats/bloc/chats_bloc.dart';
import 'package:bibinto/src/features/chats/widget/ui/screen/chat_screen.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatRootPage extends StatelessWidget {
  const ChatRootPage({
    super.key,
    required this.userId,
    required this.dialogId,
    required this.title,
  });

  final int userId;
  final int dialogId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final chatsRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) => ChatsBloc(chatsRepository.chatsRepository)
        ..add(
          FetchDialog(
            userId,
            dialogId: dialogId,
          ),
        ),
      child: ChatScreen(
        title: title,
        userId: userId,
        dialogId: dialogId,
      ),
    );
  }
}
