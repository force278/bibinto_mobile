import 'package:bibinto/src/app.dart';
import 'package:bibinto/src/common/util/core_dependencies.dart';
import 'package:bibinto/src/features/addPost/data/add_post_repository.dart';
import 'package:bibinto/src/features/auth/data/repository/auth_repository/auth_repository.dart';
import 'package:bibinto/src/features/chats/data/chats_repository.dart';
import 'package:bibinto/src/features/gallery/data/gallery_repository.dart';
import 'package:bibinto/src/features/initialize/core_depemdencies_scope.dart';
import 'package:bibinto/src/features/notifications/data/notifications_repository.dart';
import 'package:bibinto/src/features/profile/data/repository/profile_repository.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalStorage localStorage = LocalStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await localStorage.setSharedPreferences(prefs);

  runApp(
    CoreDependenciesScope(
      coreDependencies: CoreDependencies(
        authRepository: AuthRepository(),
        localStorage: localStorage,
        profileRepository: ProfileRepository(),
        galleryRepository: GalleryRepository(),
        addPostRepository: AddPostRepository(),
        chatsRepository: ChatsRepository(),
        notificationsRepository: NotificationsRepository(),
      ),
      child: const App(),
    ),
  );
}
