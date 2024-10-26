import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/notifications/bloc/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationsRootPage extends StatelessWidget {
  const NotificationsRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsRepository =
        CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) =>
          NotificationsBloc(notificationsRepository.notificationsRepository)
            ..add(FetchNotificationsEvent()),
      child: const AutoRouter(),
    );
  }
}
