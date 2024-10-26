import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';

extension AddPostRoutes on Never {
  static List<AutoRoute> makeRoutes() => [
        AutoRoute(
          path: 'add-post',
          page: AddPostRootRoute.page,
          children: [
            AutoRoute(
              path: '',
              page: AddPostRoute.page,
            ),
          ],
        ),
      ];
}
