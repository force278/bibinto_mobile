import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/followers_screen/followers_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FollowersScreen extends StatelessWidget {
  const FollowersScreen({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    final profileRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) => ProfileBloc(
        profileRepository.profileRepository,
      )..add(
          FetchFollowers(username, 1),
        ),
      child: FollowersLayout(username: username),
    );
  }
}
