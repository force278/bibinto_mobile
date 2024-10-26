import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GalleryRootPage extends StatelessWidget {
  const GalleryRootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final galleryRepository = CoreDependenciesScope.coreDependenciesOf(context);
    return BlocProvider(
      create: (context) => GalleryBloc(galleryRepository.galleryRepository),
      child: const AutoRouter(),
    );
  }
}