import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';

extension ChatsRoutes on Never {
  static List<AutoRoute> makeRoutes() => [
        AutoRoute(
          path: 'profile',
          page: ChatsRootRoute.page,
          children: [
            AutoRoute(
              path: '',
              page: ChatsRoute.page,
            ),
            AutoRoute(
              path: 'chat',
              page: ChatRootRoute.page,
            ),
          ],
        ),
      ];
}
