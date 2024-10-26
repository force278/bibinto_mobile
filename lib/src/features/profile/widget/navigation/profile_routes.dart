import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';

extension ProfileRoutes on Never {
  static List<AutoRoute> makeRoutes() => [
        AutoRoute(
          path: 'profile',
          page: ProfileRootRoute.page,
          children: [
            AutoRoute(
              path: '',
              page: ProfileRoute.page,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingRootRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: SettingsRoute.page,
                ),
                AutoRoute(
                  path: 'change-password',
                  page: EditPasswordRoute.page,
                ),
                AutoRoute(
                  path: 'confirm-account',
                  page: ConfirmAccRoute.page,
                ),
                AutoRoute(
                  path: 'write-support',
                  page: SupportRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'change-profile',
              page: ChangeProfileRootRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: ChangeProfileRoute.page,
                ),
                AutoRoute(
                  path: 'change-gender',
                  page: ChangeGenderRoute.page,
                ),
                AutoRoute(
                  path: 'change-birthday',
                  page: ChangeBirthdayRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'see-followers',
              page: FollowersRoute.page,
            ),
            AutoRoute(
              path: 'see-followers-profile',
              page: FollowersProfileRoute.page,
            ),
            AutoRoute(
              path: 'see-followers-profile',
              page: FollowingRoute.page,
            ),
            AutoRoute(
              path: 'see-posts',
              page: OpenPostRoute.page,
            ),
            AutoRoute(
              path: 'profile',
              page: ChatRootRouteInProfile.page,
            ),
          ],
        ),
      ];
}
