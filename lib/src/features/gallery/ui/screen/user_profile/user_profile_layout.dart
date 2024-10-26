import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/back_button.dart';
import 'package:bibinto/src/features/gallery/ui/screen/user_profile/widgets/info_and_button.dart';
import 'package:bibinto/src/features/gallery/ui/screen/user_profile/widgets/profile_photo_and_name.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileLayout extends StatelessWidget {
  const UserProfileLayout({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            switch (state) {
              case ProfileLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ProfileLoaded():
                return UserProfile(
                  user: state.user,
                );
              case ProfileError():
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AutoRouter.of(context)
                      .replace(const AuthenticationRootRoute());
                });
                return const SizedBox();
            }
            return Container(
              color: Colors.white,
            );
          },
        ),
      );
}

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: backButton(context),
            ),
          ],
        ),
        title: Text(
          widget.user.username,
          style: const TextStyle(
            fontFamily: 'Golos Text',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Color.fromRGBO(31, 31, 44, 1),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: const Icon(Icons.more_horiz),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromRGBO(242, 242, 247, 1),
            height: 1.0,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _topPage(context, widget.user),
                  ),
                  const SizedBox(height: 35),
                  _downPage(context, widget.user),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _topPage(
  BuildContext context,
  final UserModel user,
) {
  return Column(
    children: [
      profilePhotoAndName(user),
      const SizedBox(
        height: 20,
      ),
      InfoAndButton(user: user),
    ],
  );
}

Widget _downPage(
  BuildContext context,
  UserModel user,
) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 10,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Localized.of(context).gallery,
            style: const TextStyle(
              fontFamily: 'Golos Text',
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Color.fromRGBO(31, 31, 44, 1),
            ),
          ),
        ),
      ),
      if ((user.photos ?? []).isEmpty)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Image.asset(
              'assets/images/camera.png',
              height: 32,
              width: 42,
            ),
            const SizedBox(
              height: 10,
            ),
            user.isMe
                ? Column(
                    children: [
                      Text(
                        Localized.of(context).emptyGallery,
                        style: const TextStyle(
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Color.fromRGBO(118, 118, 140, 1),
                        ),
                      ),
                      Text(
                        Localized.of(context).addPhoto,
                        style: const TextStyle(
                          fontFamily: 'Golos Text',
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Color.fromRGBO(118, 118, 140, 1),
                        ),
                      ),
                    ],
                  )
                : Text(
                    Localized.of(context).emptyUserGallery,
                    style: const TextStyle(
                      fontFamily: 'Golos Text',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Color.fromRGBO(118, 118, 140, 1),
                    ),
                  ),
          ],
        )
      else
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: user.photos?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(
                    OpenPostRouteGallery(user: user, initialIndex: index));
              },
              child: Image.network(
                user.photos![index].file,
                fit: BoxFit.cover,
              ),
            );
          },
        )
    ],
  );
}
