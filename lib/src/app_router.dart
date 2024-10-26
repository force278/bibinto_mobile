import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/features/addPost/widget/navigation/add_post_routes.dart';
import 'package:bibinto/src/features/addPost/widget/ui/add_post_root_routes.dart';
import 'package:bibinto/src/features/addPost/widget/ui/screen/add_post_screen.dart';
import 'package:bibinto/src/features/auth/widget/navigation/authentification_routes.dart';
import 'package:bibinto/src/features/auth/widget/navigation/guard/guard.dart';
import 'package:bibinto/src/features/auth/widget/ui/auth_root_route.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/create_photo_profile_screen.dart';
import 'package:bibinto/src/features/chats/widget/navigation/chats_routes.dart';
import 'package:bibinto/src/features/chats/widget/ui/chats_root_route.dart';
import 'package:bibinto/src/features/chats/widget/ui/screen/chat_root_route.dart';
import 'package:bibinto/src/features/chats/widget/ui/screen/chats_screen.dart';
import 'package:bibinto/src/features/gallery/model/photo_model.dart';
import 'package:bibinto/src/features/gallery/ui/gallery_root_route.dart';
import 'package:bibinto/src/features/gallery/ui/navigation/gallery_routes.dart';
import 'package:bibinto/src/features/gallery/ui/screen/chat_screen/chat_root_route.dart';
import 'package:bibinto/src/features/gallery/ui/screen/followers_screen/followers_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/following_screen/following_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/gallery_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/report_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/send_report_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/user_profile/widgets/open_post_gallery.dart';
import 'package:bibinto/src/features/main/main_page.dart';
import 'package:bibinto/src/features/notifications/widget/navigation/notifications_routes.dart';
import 'package:bibinto/src/features/notifications/widget/ui/notifications_root_route.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/chat_screen/chat_root_route.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/followers_screen/followers_screen.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/following_screen/following_screen.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/notifications_screen.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/user_profile/user_profile_screen.dart';
import 'package:bibinto/src/features/notifications/widget/ui/screen/user_profile/widgets/open_post_gallery.dart';
import 'package:bibinto/src/features/profile/model/user_model.dart';
import 'package:bibinto/src/features/profile/widget/navigation/profile_routes.dart';
import 'package:bibinto/src/features/profile/widget/ui/profile_root_route.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/change_points/change_birthday_page.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/change_points/change_gender_page.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/change_profile_root_route.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/change_profile/change_profile_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/chat_screen/chat_root_route.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/followers_profile/followers_profile_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/following_screen/following_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/my_profile/profile_screen.dart';
import 'package:bibinto/src/features/gallery/ui/screen/user_profile/user_profile_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/open_post/open_post_page.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/confirm_acc_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/edit_password_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_points/support_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_root_route.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/settings/settings_screen.dart';
import 'package:bibinto/src/features/profile/widget/ui/screen/followers_screen/followers_screen.dart';
import 'package:flutter/material.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/authentification_screen.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/registration_screen.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/code_confirmation_screen.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/create_password_screen.dart';
import 'package:bibinto/src/features/auth/widget/ui/screen/basic_information_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  final GlobalKey<NavigatorState> routerKey;
  final AuthGuard authGuard;

  AppRouter(
    this.authGuard,
    this.routerKey,
  );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainFlowRouter.page,
          initial: true,
          path: '/',
          guards: [authGuard],
          children: [
            ...ProfileRoutes.makeRoutes(),
            ...NotificationsRoutes.makeRoutes(),
            ...GalleryRoutes.makeRoutes(),
            ...ChatsRoutes.makeRoutes(),
            ...AddPostRoutes.makeRoutes(),
          ],
        ),
        ...AuthenticationRoutes.makeRoutes(authGuard),
        RedirectRoute(path: '*', redirectTo: ''),
      ];
}
