import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/my_profile/widgets/enter_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class OpenPostPage extends StatefulWidget {
  const OpenPostPage({
    super.key,
    required this.user,
    required this.initialIndex,
    required this.photos,
  });

  final PhotoModel photos;
  final UserModel user;
  final int initialIndex;

  @override
  State<OpenPostPage> createState() => _OpenPostPageState();
}

class _OpenPostPageState extends State<OpenPostPage> {
  late ScrollController _scrollController;

  void _updateComments(int postId, CommentsModel newComment) {
    setState(() {
      final post = widget.user.photos?.firstWhere((p) => p.id == postId);
      post?.comments?.insert(0, newComment);
    });
  }

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
    BlocProvider.of<ProfileBloc>(context)
        .add(FetchUserProfile(widget.user.username));
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
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop<List<PhotoModel>>(
                        context, widget.user.photos);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                    height: 36,
                    width: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: widget.user.photos?.length,
              itemBuilder: (context, index) {
                final post = widget.user.photos?.any(
                            (p) => p.id == state.user.photos?[index].id) ??
                        false
                    ? widget.user.photos?.firstWhere(
                        (p) => p.id == state.user.photos?[index].id)
                    : null;
                final userAvatar = state.user.avatar;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        IconButton(
                          onPressed: () => Utils.showDoubleButtonSheet(
                            context,
                            firstButton: widget.user.isMe
                                ? null
                                : Text(
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
                                ReportRoute(recs: widget.user),
                              );
                            },
                            secondButton: widget.user.isMe
                                ? Text(
                                    Localized.of(context).deletePost,
                                    style: const TextStyle(
                                      fontFamily: 'Golos Text',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      color: Color.fromRGBO(255, 59, 48, 1),
                                    ),
                                  )
                                : widget.user.admin ?? false
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
                              BlocProvider.of<ProfileBloc>(context).add(
                                DeletePost(post?.id ?? 0),
                              );
                              setState(() {
                                widget.user.photos
                                    ?.removeWhere((p) => p.id == post?.id);
                              });
                              widget.user.isMe
                                  ? print('Удалить')
                                  : print('Заблокировать');
                            },
                          ),
                          icon: const Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    Image.network(
                      post?.file ?? '',
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context).add(
                                  ToggleLikeEvent(post?.id ?? 0, 10),
                                );
                              },
                              icon: state.user.photos?[index].isLiked ?? true
                                  ? SvgPicture.asset('assets/icons/like.svg')
                                  : SvgPicture.asset('assets/icons/heart.svg'),
                            ),
                            Text(
                              '${state.user.photos?[index].likes}',
                              style: TextStyle(
                                fontFamily: 'Golos Text',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: state.user.photos?[index].isLiked == true
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
                                                galleryRepository
                                                    .galleryRepository),
                                            child: EnterComment(
                                              comment: comments,
                                              photoId: post?.id ?? 0,
                                              user: post?.user,
                                              onCommentAdded: (newComment) {
                                                _updateComments(
                                                    post?.id ?? 0, newComment);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon:
                                  SvgPicture.asset('assets/icons/comment.svg'),
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
                        if (post?.caption != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  widget.user.username,
                                  style: const TextStyle(
                                    fontFamily: 'Golos Text',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color.fromRGBO(31, 31, 44, 1),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  post?.caption ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Golos Text',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color.fromRGBO(31, 31, 44, 1),
                                  ),
                                ),
                              ],
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
