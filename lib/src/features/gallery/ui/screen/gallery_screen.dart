import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/gallery/ui/screen/gallery_layout.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: GalleryLayout());
}
