// ignore_for_file: avoid_redundant_argument_values

import "dart:developer";
import "dart:io";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:dio_retry_plus/dio_retry_plus.dart";
import "package:flutter/foundation.dart";
import "package:flutter_clean_architecture/core/connectivity/network_info.dart";
import "package:flutter_clean_architecture/core/local_source/local_source.dart";
import "package:flutter_clean_architecture/features/home/data/data_source/remote_data_source.dart";
import "package:flutter_clean_architecture/features/home/data/repository/repository_impl.dart";
import "package:flutter_clean_architecture/features/home/domain/repository/repository.dart";
import "package:flutter_clean_architecture/router/app_routes.dart";
import "package:get_it/get_it.dart";
import "package:go_router/go_router.dart";
import "package:hive/hive.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:path_provider/path_provider.dart";

import "features/home/presentation/bloc/home_bloc.dart";

final GetIt sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> init() async {
  /// External
  await _initHive();

  /// Dio
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: "application/json",
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, String>{},
      )
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient()
            ..badCertificateCallback = (X509Certificate cert, String host, __) {
              log("cert: ${cert.pem}");
              log("host: $host");
              // return cert.pem == certificate;
              return true;
            };
          return client;
        },
        validateCertificate: (X509Certificate? cert, String host, __) {
          log("cert: ${cert?.pem}");
          log("host: $host");
          if (cert == null) {
            return true;
          }
          // Clipboard.setData(ClipboardData(text: cert.pem));
          return true;
          // return cert.pem == certificate;
        },
      )
      ..interceptors.add(
        LogInterceptor(
          error: kDebugMode,
          request: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          requestHeader: kDebugMode,
          responseHeader: kDebugMode,
          logPrint: (Object object) {
            if (kDebugMode) {
              log("dio: $object");
            }
          },
        ),
      ),
  );

  sl<Dio>().interceptors.addAll(
    <Interceptor>[
      chuck.getDioInterceptor(),
      RetryInterceptor(
        dio: sl<Dio>(),
        retries: 1,
        toNoInternetPageNavigator: () async {
          final RouteMatch lastMatch =
              router.routerDelegate.currentConfiguration.last;
          final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
              ? lastMatch.matches
              : router.routerDelegate.currentConfiguration;
          final String location = matchList.uri.toString();
          if (location.contains(Routes.noInternet)) {
            return;
          }
          await router.pushNamed(Routes.noInternet);
        },
        accessTokenGetter: () => "Bearer ${localSource.accessToken}",
        refreshTokenFunction: () async {
          await localSource.clear().then(
            (_) {
              router.goNamed(Routes.initial);
            },
          );
        },
        forbiddenFunction: () async {
          await localSource.clear().then(
            (_) {
              router.goNamed(Routes.initial);
            },
          );
        },
        logPrint: (String message) {
          if (kDebugMode) {
            log("dio: $message");
          }
        },
      ),
    ],
  );

  /// Core
  sl
    ..registerSingleton<LocalSource>(LocalSource(_box))
    ..registerLazySingleton(
      () => InternetConnectionChecker.createInstance(
        checkInterval: const Duration(seconds: 3),
      ),
    )
    ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// features:
  /// home
  ///

  sl
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl(), sl()),
    )
    ..registerFactory(() => HomeBloc(sl()));
}

Future<void> _initHive() async {
  const String boxName = "flutter_clean_architecture_box";
  final Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}
