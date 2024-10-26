import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/chats/bloc/chats_bloc.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatsRootPage extends StatelessWidget {
  const ChatsRootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatsRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) =>
          ChatsBloc(chatsRepository.chatsRepository)..add(FetchDialogs()),
      child: const AutoRouter(),
    );
  }
}
