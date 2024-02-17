import "package:chuck_interceptor/chuck.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_clean_architecture/core/connectivity/network_info.dart";
import "package:flutter_clean_architecture/core/local_source/local_source.dart";
import "package:flutter_clean_architecture/features/auth/presentation/bloc/confirm/confirm_code_bloc.dart";
import "package:flutter_clean_architecture/features/auth/presentation/bloc/login/auth_bloc.dart";
import "package:flutter_clean_architecture/features/auth/presentation/pages/auth/auth_page.dart";
import "package:flutter_clean_architecture/features/auth/presentation/pages/confirm/confirm_code_page.dart";
import "package:flutter_clean_architecture/features/catalog/presentation/pages/catalog_page.dart";
import "package:flutter_clean_architecture/features/favorites/presentation/pages/favorites_page.dart";
import "package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart";
import "package:flutter_clean_architecture/features/main/presentation/bloc/main_bloc.dart";
import "package:flutter_clean_architecture/features/main/presentation/pages/main_page.dart";
import "package:flutter_clean_architecture/features/others/presentation/pages/internet_connection/internet_connection_page.dart";
import "package:flutter_clean_architecture/features/others/presentation/pages/splash/splash_page.dart";
import "package:flutter_clean_architecture/features/profile/presentation/pages/about_us/about_us_page.dart";
import "package:flutter_clean_architecture/features/profile/presentation/pages/devices/devices_page.dart";
import "package:flutter_clean_architecture/features/profile/presentation/pages/profile_page.dart";
import "package:flutter_clean_architecture/features/profile/presentation/pages/settings/settings_page.dart";
import "package:flutter_clean_architecture/features/tv/presentation/pages/tv_page.dart";
import "package:flutter_clean_architecture/injector_container.dart";
import "package:go_router/go_router.dart";
import "package:package_info_plus/package_info_plus.dart";

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
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder:
          (_, GoRouterState state, StatefulNavigationShell navigationShell) =>
              BlocProvider<MainBloc>(
        key: state.pageKey,
        create: (_) => sl<MainBloc>(),
        child: MainPage(
          key: state.pageKey,
          navigationShell: navigationShell,
        ),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.home,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.home,
              name: Routes.home,
              builder: (_, __) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.tv,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.tv,
              name: Routes.tv,
              builder: (_, __) => const TvPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.catalog,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.catalog,
              name: Routes.catalog,
              builder: (_, __) => const CatalogPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.favorites,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.favorites,
              name: Routes.favorites,
              builder: (_, __) => const FavoritesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (_, __) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    /// home features
    // GoRoute(
    //   path: Routes.story,
    //   name: Routes.story,
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (_, __) => const StoryPage(),
    // ),

    /// profile features
    GoRoute(
      path: Routes.settings,
      name: Routes.settings,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SettingsPage(),
    ),
    GoRoute(
      path: Routes.devices,
      name: Routes.devices,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const DevicesPage(),
    ),
    GoRoute(
      path: Routes.aboutUs,
      name: Routes.aboutUs,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const AboutUsPage(),
    ),

    /// auth
    GoRoute(
      path: Routes.auth,
      name: Routes.auth,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      path: Routes.confirmCode,
      name: Routes.confirmCode,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, GoRouterState state) => BlocProvider<ConfirmCodeBloc>(
        create: (_) => sl<ConfirmCodeBloc>(),
        child: ConfirmCodePage(
          authState: state.extra! as AuthSuccessState,
        ),
      ),
    ),
    GoRoute(
      path: Routes.register,
      name: Routes.register,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
    ),
  ],
);
