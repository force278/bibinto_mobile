import 'package:bibinto/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecommendationShimmerCard extends StatelessWidget {
  const RecommendationShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: _Shimmer(borderRadius: borderRadius),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 375,
          width: double.infinity,
          child: _Shimmer(borderRadius: borderRadius),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({required this.borderRadius});
  final double borderRadius;

  @override
  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: AppColors.shimmerColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.shimmerColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: const SizedBox(height: 24),
        ),
      );
}
