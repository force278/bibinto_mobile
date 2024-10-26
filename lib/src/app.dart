import 'package:bibinto/src/features/auth/data/repository/auth_repository/auth_repository.dart';
import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:bibinto/src/features/auth/widget/navigation/guard/guard.dart';
import 'package:bibinto/src/graphql_config/graphql_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bibinto/src/features/auth/bloc/auth_bloc.dart';
import 'package:bibinto/src/app_router.dart';
import 'package:bibinto/src/common/localization/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalStorage localStorage = LocalStorage();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Future<void> _initialization;
  late final AppRouter appRouter;
  late final AuthGuard authGuard;
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  final GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initialization = initLocalStorage();
  }

  Future<void> initLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await localStorage.setSharedPreferences(prefs);
    authGuard = AuthGuard(localStorage);
    appRouter = AppRouter(authGuard, routerKey);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              AuthRepository(),
              localStorage,
            ),
            child: GraphQLProvider(
              client: graphQLConfig.clientToQuery,
              child: MaterialApp.router(
                localizationsDelegates: const [
                  Localized.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: Localized.delegate.supportedLocales,
                routerConfig: appRouter.config(),
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
