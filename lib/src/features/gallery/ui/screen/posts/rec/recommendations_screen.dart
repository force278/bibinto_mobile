import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/ui/screen/posts/rec/recommendations_post.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return BlocProvider(
      create: (context) =>
          GalleryBloc(galleryRepository.galleryRepository)..add(FetchRecs()),
      child: const RecommendationsLayout(),
    );
  }
}
