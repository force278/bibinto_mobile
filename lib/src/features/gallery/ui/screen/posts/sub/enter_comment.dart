import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/utils.dart';
import 'package:bibinto/src/features/gallery/bloc/gallery_bloc.dart';
import 'package:bibinto/src/features/gallery/model/comments_model.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnterComment extends StatefulWidget {
  const EnterComment({
    super.key,
    this.comment,
    required this.photoId,
    required this.user,
    required this.onCommentAdded,
  });

  final List<CommentsModel?>? comment;
  final int photoId;
  final UserModel? user;
  final Function(CommentsModel) onCommentAdded;

  @override
  State<EnterComment> createState() => _EnterCommentState();
}

class _EnterCommentState extends State<EnterComment> {
  final LocalStorage _localStorage = LocalStorage();
  TextEditingController enterCommentController = TextEditingController();

  void sendComment() async {
    final commentText = enterCommentController.text;
    if (commentText.isNotEmpty) {
      final userName = await _localStorage.getUserName();
      final avatar = await _localStorage.getAvatar();
      final tempComment = CommentsModel(
        user: UserModel(
          username: userName,
          avatar: avatar,
        ),
        payload: commentText,
      );

      widget.onCommentAdded(tempComment);

      final galleryBloc = BlocProvider.of<GalleryBloc>(context);
      galleryBloc.add(CreateCommentEvent(widget.photoId, commentText));
      enterCommentController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    enterCommentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GalleryBloc, GalleryState>(
      listener: (context, state) {
        if (state is CommentCreatedSuccess) {
          setState(() {});
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset('assets/icons/topStrip.svg'),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            Localized.of(context).comments,
                            style: const TextStyle(
                              fontFamily: 'Golos Text',
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                              color: Color.fromRGBO(31, 31, 44, 1),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(${widget.comment?.length ?? 0})',
                            style: const TextStyle(
                              fontFamily: 'Golos Text',
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                              color: Color.fromRGBO(118, 118, 140, 1),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.comment?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: InkWell(
                                    onTap: () {
                                      AutoRouter.of(context).push(
                                        UserProfileRoute(
                                            username: widget.comment?[index]
                                                    ?.user?.username ??
                                                ''),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            widget.comment?[index]?.user
                                                    ?.avatar ??
                                                '',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.comment?[index]?.user
                                                            ?.username ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontFamily: 'Golos Text',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          31, 31, 44, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.comment?[index]
                                                            ?.payload ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontFamily: 'Golos Text',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          31, 31, 44, 1),
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ],
                                              ),
                                              widget.comment?[index]?.isMine ??
                                                      false
                                                  ? IconButton(
                                                      onPressed: () => Utils
                                                          .showDoubleButtonSheet(
                                                        context,
                                                        firstButton: Text(
                                                          Localized.of(
                                                            context,
                                                          ).deleteCommetn,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Golos Text',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 17,
                                                            color:
                                                                Color.fromRGBO(
                                                              255,
                                                              59,
                                                              48,
                                                              1,
                                                            ),
                                                          ),
                                                        ),
                                                        firstFunc: () {
                                                          BlocProvider.of<
                                                                      GalleryBloc>(
                                                                  context)
                                                              .add(
                                                            DeleteCommentInGallery(
                                                                widget
                                                                        .comment?[
                                                                            index]
                                                                        ?.id ??
                                                                    0),
                                                          );
                                                          setState(() {
                                                            widget.comment?.removeWhere(
                                                                (comment) =>
                                                                    comment
                                                                        ?.id ==
                                                                    widget
                                                                        .comment?[
                                                                            index]
                                                                        ?.id);
                                                          });
                                                        },
                                                      ),
                                                      icon: const Icon(
                                                        Icons.more_horiz,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 0.5,
                    color: const Color.fromRGBO(216, 216, 220, 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: TextField(
                                controller: enterCommentController,
                                decoration: InputDecoration(
                                  label: Text(
                                    Localized.of(context).enterComment,
                                    style: const TextStyle(
                                      fontFamily: 'Golos Text',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Color.fromRGBO(118, 118, 140, 1),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor:
                                      const Color.fromRGBO(242, 242, 247, 1),
                                  filled: true,
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Golos Text',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color.fromRGBO(31, 31, 44, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            sendComment();
                          },
                          icon: SvgPicture.asset('assets/icons/send.svg'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
