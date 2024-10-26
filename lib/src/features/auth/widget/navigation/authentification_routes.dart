import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/features/auth/widget/navigation/guard/guard.dart';

extension AuthenticationRoutes on Never {
  static List<AutoRoute> makeRoutes(AuthGuard authGuard) => [
        AutoRoute(
          path: '/authentication',
          page: AuthenticationRootRoute.page,
          guards: [authGuard],
          children: <AutoRoute>[
            AutoRoute(
              page: AuthentificationRoute.page,
              path: '',
            ),
            AutoRoute(
              page: RegistrationRoute.page,
              path: 'registration',
            ),
            AutoRoute(
              page: CodeConfirmationRoute.page,
              path: 'confirm-code',
            ),
            AutoRoute(
              page: CreatePasswordRoute.page,
              path: 'create-password',
            ),
            AutoRoute(
              page: BasicInformationRoute.page,
              path: 'basic-information',
            ),
            AutoRoute(
              page: AddPhotoProfileRoute.page,
              path: 'add-photo',
            ),
            RedirectRoute(path: '*', redirectTo: '/'),
          ],
        ),
      ];
}
