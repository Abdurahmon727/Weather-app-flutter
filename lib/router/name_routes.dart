part of "app_routes.dart";

sealed class Routes {
  Routes._();

  static const String initial = "/";

  /// Auth
  static const String auth = "/auth";
  static const String confirmCode = "/confirm-code";
  static const String register = "/register";

  /// Home
  static const String home = "/home";
  static const String cities = "/cities";

  /// internet connection
  static const String noInternet = "/no-internet";
}
