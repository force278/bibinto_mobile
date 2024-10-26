import 'package:auto_route/auto_route.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';

class AuthGuard extends AutoRouteGuard {
  final LocalStorage localStorage;

  AuthGuard(this.localStorage);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.name == MainFlowRouter.name) {
      if (localStorage.appToken == null ||
          localStorage.appToken?.isEmpty == true) {
        resolver.next(false);
        router.root.pushAndPopUntil(
          const AuthenticationRootRoute(),
          predicate: (_) => false,
        );
        return;
      }
    } else if (resolver.route.name == AuthenticationRootRoute.name) {
      if (localStorage.appToken?.isNotEmpty ?? false) {
        resolver.next(false);
        router.root.pushAndPopUntil(
          const MainFlowRouter(),
          predicate: (_) => false,
        );
        return;
      }
    } else {
      if (localStorage.appToken == null ||
          localStorage.appToken?.isEmpty == true) {
        resolver.next(false);
        router.root.pushAndPopUntil(
          const AuthenticationRootRoute(),
          predicate: (_) => false,
        );
        return;
      }
    }
    resolver.next();
  }
}
