import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/chats/bloc/chats_bloc.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatRootPageInProfile extends StatelessWidget {
  const ChatRootPageInProfile({
    super.key,
    required this.userId,
    required this.title,
  });

  final int userId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final chatsRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) => ChatsBloc(chatsRepository.chatsRepository)
        ..add(
          FetchDialog(
            userId,
          ),
        ),
      child: ChatScreenInProfile(
        title: title,
        userId: userId,
      ),
    );
  }
}
