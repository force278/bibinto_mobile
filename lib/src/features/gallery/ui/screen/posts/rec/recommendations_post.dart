import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/model/rec_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecommendationsLayout extends StatelessWidget {
  const RecommendationsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecModel?>? recs;
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is RecsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecsLoaded) {
          recs = state.recs;
          return recommendationsPost(context: context, recs: state.recs);
        } else if (state is RecsError) {
          return recommendationsPost(context: context, recs: recs);
        }
        return Container(color: Colors.white);
      },
    );
  }
}

Widget recommendationsPost({
  required BuildContext context,
  required List<RecModel?>? recs,
}) {
  return BlocListener<GalleryBloc, GalleryState>(
    listener: (context, state) {
      if (state is RecsError) {
        showCustomErrorNotification(
          context,
          'Ошибка',
          state.message,
        );
      }
    },
    child: Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<GalleryBloc>(context).add(FetchRecs());
          return Future.value();
        },
        child: ListView.builder(
          itemCount: recs?.length,
          itemBuilder: (BuildContext context, int index) {
            final user = recs?[index]?.user;

            return RecommendationItem(
                user: user, rec: recs?[index], index: index);
          },
        ),
      ),
    ),
  );
}

class RecommendationItem extends StatelessWidget {
  final UserModel? user;
  final RecModel? rec;
  final int index;

  const RecommendationItem({
    super.key,
    required this.user,
    required this.rec,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFollowing = user?.isFollowing ?? false;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (user != null) {
                      AutoRouter.of(context).push(
                        UserProfileRoute(username: user!.username),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: const Color.fromRGBO(216, 216, 220, 1),
                          child: user?.avatar != null
                              ? Image.network(
                                  user!.avatar!,
                                  height: 40,
                                  width: 40,
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Color.fromRGBO(174, 174, 178, 1),
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user?.username ?? '',
                        style: const TextStyle(
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color.fromRGBO(31, 31, 44, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<GalleryBloc>(context).add(
                          isFollowing
                              ? UnFollowUser(user!.username)
                              : FollowUser(user!.username),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 247, 1),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          isFollowing
                              ? Localized.of(context).unsubscribe
                              : Localized.of(context).subscribe,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Utils.showDoubleButtonSheet(
                        context,
                        firstButton: Text(
                          Localized.of(context).complaint,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Color.fromRGBO(255, 59, 48, 1),
                          ),
                        ),
                        firstFunc: () {
                          AutoRouter.of(context).push(
                            ReportRoute(recs: rec!.user),
                          );
                        },
                        secondButton: rec?.user.admin ?? false
                            ? Text(
                                Localized.of(context).block,
                                style: const TextStyle(
                                  fontFamily: 'Golos Text',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Color.fromRGBO(255, 59, 48, 1),
                                ),
                              )
                            : null,
                        secondFunc: () {
                          BlocProvider.of<GalleryBloc>(context).add(
                            BanUserEvent(rec?.user.id ?? 0),
                          );
                        },
                      ),
                      icon: const Icon(Icons.more_horiz),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: rec?.file ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      color: AppColors.shimmerColor,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      color: AppColors.shimmerColor,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 35,
                  ),
                ],
              ),
              Positioned(
                bottom: 7,
                child: reactionButtons(rec: rec, context: context),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

Widget reactionButtons(
    {required RecModel? rec, required BuildContext context}) {
  if (rec == null) {
    return Container();
  }

  final bool isLiked = rec.isLiked;
  final bool isDisliked = rec.isDisliked;

  Widget likeButton = GestureDetector(
    onTap: () {
      BlocProvider.of<GalleryBloc>(context).add(
        ToggleLike(rec.id, isLiked ? 0 : 10),
      );
      BlocProvider.of<GalleryBloc>(context).add(
        GetRec(),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          isLiked ? 'assets/icons/like.svg' : 'assets/icons/heart_red.svg',
          height: 25,
          width: 27,
        ),
      ),
    ),
  );

  Widget dislikeButton = GestureDetector(
    onTap: () {
      BlocProvider.of<GalleryBloc>(context).add(
        ToggleLike(rec.id, isDisliked ? 0 : 1),
      );
      BlocProvider.of<GalleryBloc>(context).add(
        GetRec(),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          isDisliked
              ? 'assets/icons/subtract.svg'
              : 'assets/icons/subtract_light.svg',
          height: 25,
          width: 27,
        ),
      ),
    ),
  );

  if (isLiked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        likeButton,
      ],
    );
  } else if (isDisliked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dislikeButton,
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dislikeButton,
        const SizedBox(width: 30),
        likeButton,
      ],
    );
  }
}
