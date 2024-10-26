import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersLayout extends StatelessWidget {
  const FollowersLayout({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                backButton(context),
              ],
            ),
          ),
          title: Localized.of(context).followers,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileFollowersLoaded) {
              return ListFollowers(
                followers: state.followers,
                username: username,
              );
            } else if (state is ProfileError) {
              return const SizedBox();
            } else {
              return Container(
                color: Colors.white,
              );
            }
          },
        ),
      );
}

class ListFollowers extends StatelessWidget {
  const ListFollowers({
    super.key,
    required this.followers,
    required this.username,
  });

  final List<UserModel> followers;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) {
        final follower = followers[index];
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 15,
            right: 20,
          ),
          child: GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(
                FollowersProfileRoute(username: follower.username),
              );
            },
            child: Row(
              children: [
                ClipOval(
                  child: follower.avatar != null
                      ? Image.network(
                          follower.avatar ?? '',
                          height: 50,
                          width: 50,
                        )
                      : const Icon(
                          Icons.person,
                          size: 50,
                          color: Color.fromRGBO(174, 174, 178, 1),
                        ),
                ),
                const SizedBox(
                  width: 15,
                ),
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
