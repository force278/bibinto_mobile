import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingLayout extends StatelessWidget {
  const FollowingLayout({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                backButton(context),
              ],
            ),
          ),
          title: Localized.of(context).following,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileFollowingLoaded) {
              return ListFollowing(
                following: state.following,
                username: username,
              );
            } else if (state is ProfileError) {
              return const SizedBox();
            }
            return Container(
              color: Colors.white,
            );
          },
        ),
      );
}

class ListFollowing extends StatefulWidget {
  const ListFollowing({
    super.key,
    required this.following,
    required this.username,
  });

  final List<UserModel> following;
  final String username;

  @override
  ListFollowingState createState() => ListFollowingState();
}

class ListFollowingState extends State<ListFollowing> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMoreUsers(initialLoad: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchMoreUsers();
    }
  }

  void _fetchMoreUsers({bool initialLoad = false}) {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      final lastId = widget.following.isNotEmpty ? widget.following.last.id : 0;
      BlocProvider.of<ProfileBloc>(context)
          .add(FetchFollowing(widget.username, lastId ?? 0));
    }
  }

  @override
  void didUpdateWidget(ListFollowing oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.following != widget.following) {
      setState(() {
        _isLoadingMore = false;
        _hasMore = widget.following.length >= 10;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndFetchMoreIfNeeded();
      });
    }
  }

  void _checkAndFetchMoreIfNeeded() {
    if (_scrollController.position.maxScrollExtent <
            _scrollController.position.viewportDimension &&
        _hasMore) {
      _fetchMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.following.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.following.length) {
          return _isLoadingMore
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        }
        final follower = widget.following[index];
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: GestureDetector(
            onTap: () {
              AutoRouter.of(context)
                  .push(FollowersProfileRoute(username: follower.username));
            },
            child: Row(
              children: [
                ClipOval(
                  child: follower.avatar != null
                      ? Image.network(follower.avatar ?? '',
                          height: 50, width: 50)
                      : const Icon(Icons.person,
                          size: 50, color: Color.fromRGBO(174, 174, 178, 1)),
                ),
                const SizedBox(width: 15),
                Text(
                  follower.username,
                  style: const TextStyle(
                    fontFamily: 'Golos Text',
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color.fromRGBO(31, 31, 44, 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
