// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddPhotoProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddPhotoProfileScreen(),
      );
    },
    AddPostRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddPostRootPage(),
      );
    },
    AddPostRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddPostScreen(),
      );
    },
    AuthenticationRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthenticationRootPage(),
      );
    },
    AuthentificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthentificationScreen(),
      );
    },
    BasicInformationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasicInformationScreen(),
      );
    },
    ChangeBirthdayRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeBirthdayPage(),
      );
    },
    ChangeGenderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeGenderPage(),
      );
    },
    ChangeProfileRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeProfileRootPage(),
      );
    },
    ChangeProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeProfileScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    ChatRootRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRootRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatRootPage(
          key: args.key,
          userId: args.userId,
          dialogId: args.dialogId,
          title: args.title,
        ),
      );
    },
    ChatRootRouteInGallery.name: (routeData) {
      final args = routeData.argsAs<ChatRootRouteInGalleryArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatRootPageInGallery(
          key: args.key,
          userId: args.userId,
          title: args.title,
        ),
      );
    },
    ChatRootRouteInNotifications.name: (routeData) {
      final args = routeData.argsAs<ChatRootRouteInNotificationsArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatRootPageInNotifications(
          key: args.key,
          userId: args.userId,
          title: args.title,
        ),
      );
    },
    ChatRootRouteInProfile.name: (routeData) {
      final args = routeData.argsAs<ChatRootRouteInProfileArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatRootPageInProfile(
          key: args.key,
          userId: args.userId,
          title: args.title,
        ),
      );
    },
    ChatsRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatsRootPage(),
      );
    },
    ChatsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatsScreen(),
      );
    },
    CodeConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<CodeConfirmationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CodeConfirmationScreen(
          email: args.email,
          key: args.key,
        ),
      );
    },
    ConfirmAccRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfirmAccScreen(),
      );
    },
    CreatePasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreatePasswordScreen(),
      );
    },
    EditPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditPasswordScreen(),
      );
    },
    FollowersProfileRoute.name: (routeData) {
      final args = routeData.argsAs<FollowersProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FollowersProfileScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    FollowersRoute.name: (routeData) {
      final args = routeData.argsAs<FollowersRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FollowersScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    FollowingRoute.name: (routeData) {
      final args = routeData.argsAs<FollowingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FollowingScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    GalleryRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GalleryRootPage(),
      );
    },
    GalleryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GalleryScreen(),
      );
    },
    MainFlowRouter.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    NotificationsRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationsRootPage(),
      );
    },
    NotificationsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationsScreen(),
      );
    },
    OpenPostRoute.name: (routeData) {
      final args = routeData.argsAs<OpenPostRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OpenPostPage(
          key: args.key,
          user: args.user,
          initialIndex: args.initialIndex,
          photos: args.photos,
        ),
      );
    },
    OpenPostRouteGallery.name: (routeData) {
      final args = routeData.argsAs<OpenPostRouteGalleryArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OpenPostPageGallery(
          key: args.key,
          user: args.user,
          initialIndex: args.initialIndex,
        ),
      );
    },
    OpenPostRouteInNotifications.name: (routeData) {
      final args = routeData.argsAs<OpenPostRouteInNotificationsArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OpenPostPageInNotifications(
          key: args.key,
          user: args.user,
          initialIndex: args.initialIndex,
        ),
      );
    },
    ProfileRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileRootPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegistrationScreen(),
      );
    },
    ReportRoute.name: (routeData) {
      final args = routeData.argsAs<ReportRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReportScreen(
          key: args.key,
          recs: args.recs,
        ),
      );
    },
    SendReportRoute.name: (routeData) {
      final args = routeData.argsAs<SendReportRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SendReportScreen(
          key: args.key,
          themeReport: args.themeReport,
          recs: args.recs,
        ),
      );
    },
    SettingRootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingRootPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SupportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SupportScreen(),
      );
    },
    UserFollowersInNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<UserFollowersInNotificationsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserFollowersInNotificationsScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    UserFollowersRoute.name: (routeData) {
      final args = routeData.argsAs<UserFollowersRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserFollowersScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    UserFollowingInNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<UserFollowingInNotificationsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserFollowingInNotificationsScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    UserFollowingRoute.name: (routeData) {
      final args = routeData.argsAs<UserFollowingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserFollowingScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    UserProfileInNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileInNotificationsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfileInNotificationsScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfileScreen(
          key: args.key,
          username: args.username,
        ),
      );
    },
  };
}

/// generated route for
/// [AddPhotoProfileScreen]
class AddPhotoProfileRoute extends PageRouteInfo<void> {
  const AddPhotoProfileRoute({List<PageRouteInfo>? children})
      : super(
          AddPhotoProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddPhotoProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddPostRootPage]
class AddPostRootRoute extends PageRouteInfo<void> {
  const AddPostRootRoute({List<PageRouteInfo>? children})
      : super(
          AddPostRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddPostRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddPostScreen]
class AddPostRoute extends PageRouteInfo<void> {
  const AddPostRoute({List<PageRouteInfo>? children})
      : super(
          AddPostRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddPostRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthenticationRootPage]
class AuthenticationRootRoute extends PageRouteInfo<void> {
  const AuthenticationRootRoute({List<PageRouteInfo>? children})
      : super(
          AuthenticationRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthentificationScreen]
class AuthentificationRoute extends PageRouteInfo<void> {
  const AuthentificationRoute({List<PageRouteInfo>? children})
      : super(
          AuthentificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthentificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BasicInformationScreen]
class BasicInformationRoute extends PageRouteInfo<void> {
  const BasicInformationRoute({List<PageRouteInfo>? children})
      : super(
          BasicInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasicInformationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeBirthdayPage]
class ChangeBirthdayRoute extends PageRouteInfo<void> {
  const ChangeBirthdayRoute({List<PageRouteInfo>? children})
      : super(
          ChangeBirthdayRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeBirthdayRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeGenderPage]
class ChangeGenderRoute extends PageRouteInfo<void> {
  const ChangeGenderRoute({List<PageRouteInfo>? children})
      : super(
          ChangeGenderRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeGenderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeProfileRootPage]
class ChangeProfileRootRoute extends PageRouteInfo<void> {
  const ChangeProfileRootRoute({List<PageRouteInfo>? children})
      : super(
          ChangeProfileRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeProfileRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeProfileScreen]
class ChangeProfileRoute extends PageRouteInfo<ChangeProfileRouteArgs> {
  ChangeProfileRoute({
    Key? key,
    required UserModel user,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeProfileRoute.name,
          args: ChangeProfileRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangeProfileRoute';

  static const PageInfo<ChangeProfileRouteArgs> page =
      PageInfo<ChangeProfileRouteArgs>(name);
}

class ChangeProfileRouteArgs {
  const ChangeProfileRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final UserModel user;

  @override
  String toString() {
    return 'ChangeProfileRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [ChatRootPage]
class ChatRootRoute extends PageRouteInfo<ChatRootRouteArgs> {
  ChatRootRoute({
    Key? key,
    required int userId,
    required int dialogId,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRootRoute.name,
          args: ChatRootRouteArgs(
            key: key,
            userId: userId,
            dialogId: dialogId,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRootRoute';

  static const PageInfo<ChatRootRouteArgs> page =
      PageInfo<ChatRootRouteArgs>(name);
}

class ChatRootRouteArgs {
  const ChatRootRouteArgs({
    this.key,
    required this.userId,
    required this.dialogId,
    required this.title,
  });

  final Key? key;

  final int userId;

  final int dialogId;

  final String title;

  @override
  String toString() {
    return 'ChatRootRouteArgs{key: $key, userId: $userId, dialogId: $dialogId, title: $title}';
  }
}

/// generated route for
/// [ChatRootPageInGallery]
class ChatRootRouteInGallery extends PageRouteInfo<ChatRootRouteInGalleryArgs> {
  ChatRootRouteInGallery({
    Key? key,
    required int userId,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRootRouteInGallery.name,
          args: ChatRootRouteInGalleryArgs(
            key: key,
            userId: userId,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRootRouteInGallery';

  static const PageInfo<ChatRootRouteInGalleryArgs> page =
      PageInfo<ChatRootRouteInGalleryArgs>(name);
}

class ChatRootRouteInGalleryArgs {
  const ChatRootRouteInGalleryArgs({
    this.key,
    required this.userId,
    required this.title,
  });

  final Key? key;

  final int userId;

  final String title;

  @override
  String toString() {
    return 'ChatRootRouteInGalleryArgs{key: $key, userId: $userId, title: $title}';
  }
}

/// generated route for
/// [ChatRootPageInNotifications]
class ChatRootRouteInNotifications
    extends PageRouteInfo<ChatRootRouteInNotificationsArgs> {
  ChatRootRouteInNotifications({
    Key? key,
    required int userId,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRootRouteInNotifications.name,
          args: ChatRootRouteInNotificationsArgs(
            key: key,
            userId: userId,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRootRouteInNotifications';

  static const PageInfo<ChatRootRouteInNotificationsArgs> page =
      PageInfo<ChatRootRouteInNotificationsArgs>(name);
}

class ChatRootRouteInNotificationsArgs {
  const ChatRootRouteInNotificationsArgs({
    this.key,
    required this.userId,
    required this.title,
  });

  final Key? key;

  final int userId;

  final String title;

  @override
  String toString() {
    return 'ChatRootRouteInNotificationsArgs{key: $key, userId: $userId, title: $title}';
  }
}

/// generated route for
/// [ChatRootPageInProfile]
class ChatRootRouteInProfile extends PageRouteInfo<ChatRootRouteInProfileArgs> {
  ChatRootRouteInProfile({
    Key? key,
    required int userId,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRootRouteInProfile.name,
          args: ChatRootRouteInProfileArgs(
            key: key,
            userId: userId,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRootRouteInProfile';

  static const PageInfo<ChatRootRouteInProfileArgs> page =
      PageInfo<ChatRootRouteInProfileArgs>(name);
}

class ChatRootRouteInProfileArgs {
  const ChatRootRouteInProfileArgs({
    this.key,
    required this.userId,
    required this.title,
  });

  final Key? key;

  final int userId;

  final String title;

  @override
  String toString() {
    return 'ChatRootRouteInProfileArgs{key: $key, userId: $userId, title: $title}';
  }
}

/// generated route for
/// [ChatsRootPage]
class ChatsRootRoute extends PageRouteInfo<void> {
  const ChatsRootRoute({List<PageRouteInfo>? children})
      : super(
          ChatsRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatsRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatsScreen]
class ChatsRoute extends PageRouteInfo<void> {
  const ChatsRoute({List<PageRouteInfo>? children})
      : super(
          ChatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CodeConfirmationScreen]
class CodeConfirmationRoute extends PageRouteInfo<CodeConfirmationRouteArgs> {
  CodeConfirmationRoute({
    required String email,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CodeConfirmationRoute.name,
          args: CodeConfirmationRouteArgs(
            email: email,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CodeConfirmationRoute';

  static const PageInfo<CodeConfirmationRouteArgs> page =
      PageInfo<CodeConfirmationRouteArgs>(name);
}

class CodeConfirmationRouteArgs {
  const CodeConfirmationRouteArgs({
    required this.email,
    this.key,
  });

  final String email;

  final Key? key;

  @override
  String toString() {
    return 'CodeConfirmationRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [ConfirmAccScreen]
class ConfirmAccRoute extends PageRouteInfo<void> {
  const ConfirmAccRoute({List<PageRouteInfo>? children})
      : super(
          ConfirmAccRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmAccRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreatePasswordScreen]
class CreatePasswordRoute extends PageRouteInfo<void> {
  const CreatePasswordRoute({List<PageRouteInfo>? children})
      : super(
          CreatePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatePasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditPasswordScreen]
class EditPasswordRoute extends PageRouteInfo<void> {
  const EditPasswordRoute({List<PageRouteInfo>? children})
      : super(
          EditPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FollowersProfileScreen]
class FollowersProfileRoute extends PageRouteInfo<FollowersProfileRouteArgs> {
  FollowersProfileRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          FollowersProfileRoute.name,
          args: FollowersProfileRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'FollowersProfileRoute';

  static const PageInfo<FollowersProfileRouteArgs> page =
      PageInfo<FollowersProfileRouteArgs>(name);
}

class FollowersProfileRouteArgs {
  const FollowersProfileRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'FollowersProfileRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [FollowersScreen]
class FollowersRoute extends PageRouteInfo<FollowersRouteArgs> {
  FollowersRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          FollowersRoute.name,
          args: FollowersRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'FollowersRoute';

  static const PageInfo<FollowersRouteArgs> page =
      PageInfo<FollowersRouteArgs>(name);
}

class FollowersRouteArgs {
  const FollowersRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'FollowersRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [FollowingScreen]
class FollowingRoute extends PageRouteInfo<FollowingRouteArgs> {
  FollowingRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          FollowingRoute.name,
          args: FollowingRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'FollowingRoute';

  static const PageInfo<FollowingRouteArgs> page =
      PageInfo<FollowingRouteArgs>(name);
}

class FollowingRouteArgs {
  const FollowingRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'FollowingRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [GalleryRootPage]
class GalleryRootRoute extends PageRouteInfo<void> {
  const GalleryRootRoute({List<PageRouteInfo>? children})
      : super(
          GalleryRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'GalleryRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GalleryScreen]
class GalleryRoute extends PageRouteInfo<void> {
  const GalleryRoute({List<PageRouteInfo>? children})
      : super(
          GalleryRoute.name,
          initialChildren: children,
        );

  static const String name = 'GalleryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainFlowRouter extends PageRouteInfo<void> {
  const MainFlowRouter({List<PageRouteInfo>? children})
      : super(
          MainFlowRouter.name,
          initialChildren: children,
        );

  static const String name = 'MainFlowRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationsRootPage]
class NotificationsRootRoute extends PageRouteInfo<void> {
  const NotificationsRootRoute({List<PageRouteInfo>? children})
      : super(
          NotificationsRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationsScreen]
class NotificationsRoute extends PageRouteInfo<void> {
  const NotificationsRoute({List<PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OpenPostPage]
class OpenPostRoute extends PageRouteInfo<OpenPostRouteArgs> {
  OpenPostRoute({
    Key? key,
    required UserModel user,
    required int initialIndex,
    required PhotoModel photos,
    List<PageRouteInfo>? children,
  }) : super(
          OpenPostRoute.name,
          args: OpenPostRouteArgs(
            key: key,
            user: user,
            initialIndex: initialIndex,
            photos: photos,
          ),
          initialChildren: children,
        );

  static const String name = 'OpenPostRoute';

  static const PageInfo<OpenPostRouteArgs> page =
      PageInfo<OpenPostRouteArgs>(name);
}

class OpenPostRouteArgs {
  const OpenPostRouteArgs({
    this.key,
    required this.user,
    required this.initialIndex,
    required this.photos,
  });

  final Key? key;

  final UserModel user;

  final int initialIndex;

  final PhotoModel photos;

  @override
  String toString() {
    return 'OpenPostRouteArgs{key: $key, user: $user, initialIndex: $initialIndex, photos: $photos}';
  }
}

/// generated route for
/// [OpenPostPageGallery]
class OpenPostRouteGallery extends PageRouteInfo<OpenPostRouteGalleryArgs> {
  OpenPostRouteGallery({
    Key? key,
    required UserModel user,
    required int initialIndex,
    List<PageRouteInfo>? children,
  }) : super(
          OpenPostRouteGallery.name,
          args: OpenPostRouteGalleryArgs(
            key: key,
            user: user,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'OpenPostRouteGallery';

  static const PageInfo<OpenPostRouteGalleryArgs> page =
      PageInfo<OpenPostRouteGalleryArgs>(name);
}

class OpenPostRouteGalleryArgs {
  const OpenPostRouteGalleryArgs({
    this.key,
    required this.user,
    required this.initialIndex,
  });

  final Key? key;

  final UserModel user;

  final int initialIndex;

  @override
  String toString() {
    return 'OpenPostRouteGalleryArgs{key: $key, user: $user, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [OpenPostPageInNotifications]
class OpenPostRouteInNotifications
    extends PageRouteInfo<OpenPostRouteInNotificationsArgs> {
  OpenPostRouteInNotifications({
    Key? key,
    required UserModel user,
    required int initialIndex,
    List<PageRouteInfo>? children,
  }) : super(
          OpenPostRouteInNotifications.name,
          args: OpenPostRouteInNotificationsArgs(
            key: key,
            user: user,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'OpenPostRouteInNotifications';

  static const PageInfo<OpenPostRouteInNotificationsArgs> page =
      PageInfo<OpenPostRouteInNotificationsArgs>(name);
}

class OpenPostRouteInNotificationsArgs {
  const OpenPostRouteInNotificationsArgs({
    this.key,
    required this.user,
    required this.initialIndex,
  });

  final Key? key;

  final UserModel user;

  final int initialIndex;

  @override
  String toString() {
    return 'OpenPostRouteInNotificationsArgs{key: $key, user: $user, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [ProfileRootPage]
class ProfileRootRoute extends PageRouteInfo<void> {
  const ProfileRootRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute({List<PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportScreen]
class ReportRoute extends PageRouteInfo<ReportRouteArgs> {
  ReportRoute({
    Key? key,
    required UserModel recs,
    List<PageRouteInfo>? children,
  }) : super(
          ReportRoute.name,
          args: ReportRouteArgs(
            key: key,
            recs: recs,
          ),
          initialChildren: children,
        );

  static const String name = 'ReportRoute';

  static const PageInfo<ReportRouteArgs> page = PageInfo<ReportRouteArgs>(name);
}

class ReportRouteArgs {
  const ReportRouteArgs({
    this.key,
    required this.recs,
  });

  final Key? key;

  final UserModel recs;

  @override
  String toString() {
    return 'ReportRouteArgs{key: $key, recs: $recs}';
  }
}

/// generated route for
/// [SendReportScreen]
class SendReportRoute extends PageRouteInfo<SendReportRouteArgs> {
  SendReportRoute({
    Key? key,
    required String themeReport,
    required UserModel recs,
    List<PageRouteInfo>? children,
  }) : super(
          SendReportRoute.name,
          args: SendReportRouteArgs(
            key: key,
            themeReport: themeReport,
            recs: recs,
          ),
          initialChildren: children,
        );

  static const String name = 'SendReportRoute';

  static const PageInfo<SendReportRouteArgs> page =
      PageInfo<SendReportRouteArgs>(name);
}

class SendReportRouteArgs {
  const SendReportRouteArgs({
    this.key,
    required this.themeReport,
    required this.recs,
  });

  final Key? key;

  final String themeReport;

  final UserModel recs;

  @override
  String toString() {
    return 'SendReportRouteArgs{key: $key, themeReport: $themeReport, recs: $recs}';
  }
}

/// generated route for
/// [SettingRootPage]
class SettingRootRoute extends PageRouteInfo<void> {
  const SettingRootRoute({List<PageRouteInfo>? children})
      : super(
          SettingRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SupportScreen]
class SupportRoute extends PageRouteInfo<void> {
  const SupportRoute({List<PageRouteInfo>? children})
      : super(
          SupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserFollowersInNotificationsScreen]
class UserFollowersInNotificationsRoute
    extends PageRouteInfo<UserFollowersInNotificationsRouteArgs> {
  UserFollowersInNotificationsRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserFollowersInNotificationsRoute.name,
          args: UserFollowersInNotificationsRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserFollowersInNotificationsRoute';

  static const PageInfo<UserFollowersInNotificationsRouteArgs> page =
      PageInfo<UserFollowersInNotificationsRouteArgs>(name);
}

class UserFollowersInNotificationsRouteArgs {
  const UserFollowersInNotificationsRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserFollowersInNotificationsRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [UserFollowersScreen]
class UserFollowersRoute extends PageRouteInfo<UserFollowersRouteArgs> {
  UserFollowersRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserFollowersRoute.name,
          args: UserFollowersRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserFollowersRoute';

  static const PageInfo<UserFollowersRouteArgs> page =
      PageInfo<UserFollowersRouteArgs>(name);
}

class UserFollowersRouteArgs {
  const UserFollowersRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserFollowersRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [UserFollowingInNotificationsScreen]
class UserFollowingInNotificationsRoute
    extends PageRouteInfo<UserFollowingInNotificationsRouteArgs> {
  UserFollowingInNotificationsRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserFollowingInNotificationsRoute.name,
          args: UserFollowingInNotificationsRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserFollowingInNotificationsRoute';

  static const PageInfo<UserFollowingInNotificationsRouteArgs> page =
      PageInfo<UserFollowingInNotificationsRouteArgs>(name);
}

class UserFollowingInNotificationsRouteArgs {
  const UserFollowingInNotificationsRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserFollowingInNotificationsRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [UserFollowingScreen]
class UserFollowingRoute extends PageRouteInfo<UserFollowingRouteArgs> {
  UserFollowingRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserFollowingRoute.name,
          args: UserFollowingRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserFollowingRoute';

  static const PageInfo<UserFollowingRouteArgs> page =
      PageInfo<UserFollowingRouteArgs>(name);
}

class UserFollowingRouteArgs {
  const UserFollowingRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserFollowingRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [UserProfileInNotificationsScreen]
class UserProfileInNotificationsRoute
    extends PageRouteInfo<UserProfileInNotificationsRouteArgs> {
  UserProfileInNotificationsRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileInNotificationsRoute.name,
          args: UserProfileInNotificationsRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfileInNotificationsRoute';

  static const PageInfo<UserProfileInNotificationsRouteArgs> page =
      PageInfo<UserProfileInNotificationsRouteArgs>(name);
}

class UserProfileInNotificationsRouteArgs {
  const UserProfileInNotificationsRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserProfileInNotificationsRouteArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            key: key,
            username: username,
          ),
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<UserProfileRouteArgs> page =
      PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key, username: $username}';
  }
}
