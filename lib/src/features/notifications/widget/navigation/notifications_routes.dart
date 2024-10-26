import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';

extension NotificationsRoutes on Never {
  static List<AutoRoute> makeRoutes() => [
        AutoRoute(
          path: 'notifications',
          page: NotificationsRootRoute.page,
          children: <AutoRoute>[
            AutoRoute(
              page: NotificationsRoute.page,
              path: '',
            ),
            AutoRoute(
              page: UserProfileInNotificationsRoute.page,
              path: '',
            ),
            AutoRoute(
              page: UserFollowersInNotificationsRoute.page,
              path: '',
            ),
            AutoRoute(
              page: UserFollowingInNotificationsRoute.page,
              path: '',
            ),
            AutoRoute(
              page: OpenPostRouteInNotifications.page,
              path: '',
            ),
            AutoRoute(
              page: ChatRootRouteInNotifications.page,
              path: '',
            ),
          ],
        ),
      ];
}
