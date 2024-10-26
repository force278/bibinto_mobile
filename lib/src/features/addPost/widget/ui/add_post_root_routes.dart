import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/addPost/bloc/add_post_bloc.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddPostRootPage extends StatelessWidget {
  const AddPostRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addPostRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) => AddPostBloc(addPostRepository.addPostRepository),
      child: const AutoRouter(),
    );
  }
}
