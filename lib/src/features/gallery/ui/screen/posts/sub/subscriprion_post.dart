import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/gallery/model/rec_model.dart';
import 'package:bibinto/src/features/gallery/ui/screen/posts/sub/enter_comment.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionLayout extends StatelessWidget {
  const SubscriptionLayout({super.key});

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
          return Post(post: state.recs);
        } else if (state is RecsError) {
          return Post(post: recs ?? []);
        }
        return Post(post: recs ?? []);
      },
    );
  }
}

class Post extends StatefulWidget {
  const Post({
    super.key,
    required this.post,
  });
  final List<RecModel?> post;
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentOffset = 0;
  // ignore: unused_field
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _isLoading = true;
      BlocProvider.of<GalleryBloc>(context).add(FetchFeed(_currentOffset + 5));
      _currentOffset += 5;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<GalleryBloc, GalleryState>(
      listener: (context, state) {
        if (state is RecsError) {
          showCustomErrorNotification(
            context,
            'Ошибка',
            state.message,
          );
        } else if (state is RecsLoaded) {
          _isLoading = false;
          widget.post.addAll(state.recs);
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          _currentOffset = 0;
          BlocProvider.of<GalleryBloc>(context).add(FetchFeed(0));
          return Future.value();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.post.length + 1,
          addAutomaticKeepAlives: true,
          cacheExtent: 1000.0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index >= widget.post.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final post = widget.post[index];
            if (post != null) {
              return PostItem(
                post: post,
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final RecModel post;

  @override
  PostItemState createState() => PostItemState();
}

class PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    final galleryRepository = CoreDependenciesScope.coreDependenciesOf(context);
    const EdgeInsets postPadding = EdgeInsets.only(
      left: 20,
      right: 20,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: postPadding,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    UserProfileRoute(username: widget.post.user.username),
                  );
                },
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        color: const Color.fromRGBO(216, 216, 220, 1),
                        child: widget.post.user.avatar != null
                            ? Image.network(
                                widget.post.user.avatar ?? '',
                                height: 40,
                                width: 40,
                              )
                            : const Icon(Icons.person, size: 40),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.post.user.username,
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
            ),
            IconButton(
              onPressed: () => Utils.showDoubleButtonSheet(
                context,
                firstButton: widget.post.user.isMe
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
                    ReportRoute(recs: widget.post.user),
                  );
                },
                secondButton: widget.post.user.isMe
                    ? Text(
                        Localized.of(context).deletePost,
                        style: const TextStyle(
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Color.fromRGBO(255, 59, 48, 1),
                        ),
                      )
                    : widget.post.user.admin ?? false
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
                  widget.post.user.isMe
                      ? BlocProvider.of<GalleryBloc>(context).add(
                          DeletePhoto(widget.post.id),
                        )
                      : BlocProvider.of<GalleryBloc>(context).add(
                          BanUserEvent(widget.post.user.id ?? 0),
                        );
                  widget.post.user.isMe
                      ? print('Удален')
                      : print('Заблокировать');
                },
              ),
              icon: const Icon(Icons.more_horiz),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        CachedNetworkImage(
          imageUrl: widget.post.file,
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
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<GalleryBloc>(context).add(
                      ToggleLike(widget.post.id, 10),
                    );
                  },
                  icon: widget.post.isLiked
                      ? SvgPicture.asset('assets/icons/like.svg')
                      : SvgPicture.asset('assets/icons/heart.svg'),
                ),
                Text(
                  '${widget.post.likes}',
                  style: TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: widget.post.isLiked
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
                      builder: (BuildContext context) => FractionallySizedBox(
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
                                  comment: widget.post.comments,
                                  photoId: widget.post.id,
                                  user: widget.post.user,
                                  onCommentAdded: (CommentsModel newComment) {
                                    setState(() {
                                      if (widget.post.comments != null) {
                                        widget.post.comments!
                                            .insert(0, newComment);
                                      }
                                    });
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
                  '${widget.post.comments?.length}',
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Color.fromRGBO(31, 31, 44, 1),
                  ),
                ),
              ],
            ),
            if (widget.post.caption != null)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      widget.post.user.username,
                      style: const TextStyle(
                        fontFamily: 'Golos Text',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 31, 44, 1),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.post.caption ?? '',
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
        if (widget.post.comments?.isNotEmpty ?? false)
          Padding(
            padding: postPadding,
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
          padding: postPadding,
          child: Column(
            children: [
              ...widget.post.comments?.take(3).map((comment) {
                    return Row(
                      children: [
                        Text(
                          comment?.user?.username ?? '',
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color.fromRGBO(31, 31, 44, 1),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            comment?.payload ?? '',
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
                  }).toList() ??
                  [],
              if ((widget.post.comments?.length ?? 0) > 3)
                Align(
                  alignment: Alignment.centerLeft,
                  child: (widget.post.comments!.length - 3) == 1
                      ? Text(
                          Localized.of(context)
                              .andMoreComment(widget.post.comments!.length - 3),
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(118, 118, 140, 1),
                          ),
                        )
                      : Text(
                          Localized.of(context).andMoreComments(
                              widget.post.comments!.length - 3),
                          style: const TextStyle(
                            fontFamily: 'Golos Text',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(118, 118, 140, 1),
                          ),
                        ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
