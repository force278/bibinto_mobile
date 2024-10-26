import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/ui/screen/posts/sub/enter_comment.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class OpenPostPageGallery extends StatefulWidget {
  const OpenPostPageGallery({
    super.key,
    required this.user,
    required this.initialIndex,
  });

  final UserModel user;
  final int initialIndex;

  @override
  State<OpenPostPageGallery> createState() => _OpenPostPageState();
}

class _OpenPostPageState extends State<OpenPostPageGallery> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex > 0 && _scrollController.hasClients) {
        double screenWidth = MediaQuery.of(context).size.width;
        double position = widget.initialIndex * screenWidth;
        _scrollController.jumpTo(position);
      }
    });

    BlocProvider.of<GalleryBloc>(context).add(FetchUser(widget.user.username));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final galleryRepository = CoreDependenciesScope.coreDependenciesOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.user.username,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backButton(context),
            ],
          ),
        ),
      ),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is UserProfileLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: widget.user.photos?.length,
              itemBuilder: (context, index) {
                final post = widget.user.photos?.any(
                            (p) => p.id == widget.user.photos?[index].id) ??
                        false
                    ? widget.user.photos?.firstWhere(
                        (p) => p.id == widget.user.photos?[index].id)
                    : null;
                final userAvatar = widget.user.avatar;
                final comments = post?.comments ?? [];
                final commentCount = comments.length;
                final moreComments = commentCount - 3;

                Widget buildCommentRow(comment) {
                  return Row(
                    children: [
                      Text(
                        comment.user?.username ?? '',
                        style: const TextStyle(
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color.fromRGBO(31, 31, 44, 1),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          comment.payload ?? '',
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ClipOval(
                            child: Container(
                              color: const Color.fromRGBO(216, 216, 220, 1),
                              child: userAvatar != null
                                  ? Image.network(
                                      userAvatar,
                                      height: 40,
                                      width: 40,
                                    )
                                  : const Icon(Icons.person, size: 40),
                            ),
                          ),
                        ),
                        Text(
                          widget.user.username,
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      post?.file ?? '',
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<GalleryBloc>(context).add(
                              ToggleLikeProfile(post?.id ?? 0, 10),
                            );
                          },
                          icon: state.userProfile.photos?[index].isLiked == true
                              ? SvgPicture.asset('assets/icons/like.svg')
                              : SvgPicture.asset('assets/icons/heart.svg'),
                        ),
                        Text(
                          '${state.userProfile.photos?[index].likes}',
                          style: TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color:
                                state.userProfile.photos?[index].isLiked == true
                                    ? const Color.fromRGBO(255, 59, 48, 1)
                                    : const Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              barrierColor: Colors.black.withOpacity(0.5),
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) =>
                                  FractionallySizedBox(
                                heightFactor: 0.9,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => GalleryBloc(
                                          galleryRepository.galleryRepository,
                                        ),
                                        child: EnterComment(
                                          comment: comments,
                                          photoId: post?.id ?? 0,
                                          user: post?.user,
                                          onCommentAdded: (newComment) {
                                            setState(
                                              () {
                                                comments.insert(0, newComment);
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: SvgPicture.asset('assets/icons/comment.svg'),
                        ),
                        Text(
                          '$commentCount',
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                      ],
                    ),
                    if (comments.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${Localized.of(context).comments}:',
                            style: const TextStyle(
                              fontFamily: 'Golos Text',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(118, 118, 140, 1),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ...comments.take(3).map(buildCommentRow),
                          if (moreComments > 0)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Localized.of(context)
                                    .andMoreComments(moreComments),
                                style: const TextStyle(
                                  fontFamily: 'Golos Text',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color.fromRGBO(118, 118, 140, 1),
                                ),
                              ),
                            ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
