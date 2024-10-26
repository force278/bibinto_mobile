import 'package:bibinto/src/features/addPost/data/add_post_repository.dart';
import 'package:bibinto/src/features/auth/data/repository/auth_repository/auth_repository.dart';
import 'package:bibinto/src/features/chats/data/chats_repository.dart';
import 'package:bibinto/src/features/gallery/data/gallery_repository.dart';
import 'package:bibinto/src/features/notifications/data/notifications_repository.dart';
import 'package:bibinto/src/features/profile/data/repository/profile_repository.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:flutter/material.dart';

@immutable
class CoreDependencies {
  const CoreDependencies({
    required this.authRepository,
    required this.profileRepository,
    required this.galleryRepository,
    required this.addPostRepository,
    required this.chatsRepository,
    required this.notificationsRepository,
    required this.localStorage,
  });

  final AuthRepository authRepository;

  final ProfileRepository profileRepository;

  final GalleryRepository galleryRepository;

  final AddPostRepository addPostRepository;

  final ChatsRepository chatsRepository;

  final NotificationsRepository notificationsRepository;

  final LocalStorage localStorage;
}
