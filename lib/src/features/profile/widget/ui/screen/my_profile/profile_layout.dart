import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:bibinto/src/common/widgets/error_notification.dart';
import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:bibinto/src/features/gallery/ui/screen/user_profile/widgets/profile_photo_and_name.dart';
import 'package:bibinto/src/features/profile/bloc/profile_bloc.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/my_profile/widgets/info_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  void _refreshProfile(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(IsMe());
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user;
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            user = state.user;
            return Profile(
              user: state.user,
              onRefresh: () => _refreshProfile(context),
            );
          } else if (state is ProfileError) {
            return user != null
                ? Profile(
                    user: user!,
                    onRefresh: () => _refreshProfile(context),
                  )
                : const Center(child: Text('Error loading profile'));
          }
          return Container(
            color: Colors.white,
          );
        },
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.user,
    required this.onRefresh,
  });

  final UserModel user;
  final VoidCallback onRefresh;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
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
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    const SettingsRoute(),
                  );
                },
                icon: const Icon(Icons.sort),
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
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              showCustomErrorNotification(
                context,
                'Ошибка',
                state.message,
              );
            }
          },
          child: RefreshIndicator(
            onRefresh: () {
              widget.onRefresh();
              return Future.value();
            },
            child: CustomScrollView(
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
          ),
        ),
      ),
    );
  }

  Widget _downPage(
    BuildContext context,
    UserModel user,
  ) {
    List<PhotoModel> sortPhotosByDate(List<PhotoModel>? photos) {
      if (photos == null) return [];
      photos.sort((b, a) {
        if (a.createdAt == null && b.createdAt == null) return 0;
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return a.createdAt!.compareTo(b.createdAt!);
      });
      return photos;
    }

    List<PhotoModel> sortedPhotos = sortPhotosByDate(user.photos);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: sortedPhotos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final updatedPhotos = await AutoRouter.of(context).push(
                    OpenPostRoute(
                      user: user,
                      initialIndex: index,
                      photos: user.photos![index],
                    ),
                  ) as List<PhotoModel>?;
                  if (updatedPhotos != null) {
                    setState(() {
                      user = user.copyWith(photos: updatedPhotos);
                    });
                  }
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
      infoAndButton(context, user),
    ],
  );
}
