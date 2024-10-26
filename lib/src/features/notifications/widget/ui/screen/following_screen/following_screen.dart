import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/ui/screen/following_screen/following_layout.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserFollowingInNotificationsScreen extends StatelessWidget {
  const UserFollowingInNotificationsScreen({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    final galleryRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) => GalleryBloc(
        galleryRepository.galleryRepository,
      )..add(
          UserFetchFollowing(username, 0),
        ),
      child: UserFollowingLayout(username: username),
    );
  }
}
