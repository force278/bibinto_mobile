import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';

extension GalleryRoutes on Never {
  static List<AutoRoute> makeRoutes() => [
        AutoRoute(
          path: 'gallery',
          page: GalleryRootRoute.page,
          children: [
            AutoRoute(
              path: '',
              page: GalleryRoute.page,
            ),
            AutoRoute(
              path: 'report',
              page: ReportRoute.page,
            ),
            AutoRoute(
              path: 'send-report',
              page: SendReportRoute.page,
            ),
            AutoRoute(
              path: 'user-prifile',
              page: UserProfileRoute.page,
            ),
            AutoRoute(
              path: 'user-followers',
              page: UserFollowersRoute.page,
            ),
            AutoRoute(
              path: 'user-following',
              page: UserFollowingRoute.page,
            ),
            AutoRoute(
              path: 'post',
              page: OpenPostRouteGallery.page,
            ),
            AutoRoute(
              path: 'user-chat',
              page: ChatRootRouteInGallery.page,
            ),
          ],
        ),
      ];
}
