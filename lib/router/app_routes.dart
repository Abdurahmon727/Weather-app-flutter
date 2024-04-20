import "package:chuck_interceptor/chuck.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_clean_architecture/core/connectivity/network_info.dart";
import "package:flutter_clean_architecture/core/local_source/local_source.dart";
import "package:flutter_clean_architecture/features/home/presentation/pages/cities_page.dart";
import "package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart";
import "package:flutter_clean_architecture/features/others/presentation/pages/internet_connection/internet_connection_page.dart";
import "package:flutter_clean_architecture/features/others/presentation/pages/splash/splash_page.dart";
import "package:flutter_clean_architecture/injector_container.dart";
import "package:go_router/go_router.dart";
import "package:package_info_plus/package_info_plus.dart";

import "../features/home/presentation/bloc/home/home_bloc.dart";

part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final PackageInfo packageInfo = sl<PackageInfo>();
final NetworkInfo networkInfo = sl<NetworkInfo>();
final LocalSource localSource = sl<LocalSource>();

final Chuck chuck = Chuck(navigatorKey: rootNavigatorKey);

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.noInternet,
      name: Routes.noInternet,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const InternetConnectionPage(),
    ),

    GoRoute(
      path: Routes.home,
      name: Routes.home,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<HomeBloc>(),
        child: const HomePage(),
      ),
    ),

    GoRoute(
      path: Routes.cities,
      name: Routes.cities,
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (_) => sl<HomeBloc>(),
          child: const CitiesPage(),
        ),
      ),
    ),

    // StatefulShellRoute.indexedStack(
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (
    //     _,
    //     GoRouterState state,
    //     StatefulNavigationShell navigationShell,
    //   ) =>
    //       BlocProvider<MainBloc>(
    //     key: state.pageKey,
    //     create: (_) => sl<MainBloc>(),
    //     child: MainPage(
    //       key: state.pageKey,
    //       navigationShell: navigationShell,
    //     ),
    //   ),
    //   branches: <StatefulShellBranch>[
    //     StatefulShellBranch(
    //       initialLocation: Routes.home,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: Routes.home,
    //           name: Routes.home,
    //           builder: (_, __) => const HomePage(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       initialLocation: Routes.tv,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: Routes.tv,
    //           name: Routes.tv,
    //           builder: (_, __) => const TvPage(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       initialLocation: Routes.catalog,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: Routes.catalog,
    //           name: Routes.catalog,
    //           builder: (_, __) => const CatalogPage(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       initialLocation: Routes.favorites,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: Routes.favorites,
    //           name: Routes.favorites,
    //           builder: (_, __) => const FavoritesPage(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       initialLocation: Routes.profile,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: Routes.profile,
    //           name: Routes.profile,
    //           builder: (_, __) => const ProfilePage(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),

    /// home features
    // GoRoute(
    //   path: Routes.story,
    //   name: Routes.story,
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (_, __) => const StoryPage(),
    // ),
  ],
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
