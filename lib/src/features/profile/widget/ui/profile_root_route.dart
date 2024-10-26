import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileRootPage extends StatelessWidget {
  const ProfileRootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileRepository = CoreDependenciesScope.coreDependenciesOf(context);
    return BlocProvider(
      create: (context) => ProfileBloc(profileRepository.profileRepository),
      child: const AutoRouter(),
    );
  }
}
