sealed class Constants {
  Constants._();

  static const String baseUrl = "https://api.openweathermap.org";
  static const String apiKey = "6c7ee912b674db54b61d70801f4cc33d";
}

sealed class AppKeys {
  AppKeys._();

  static const String locale = "locale";
  static const String hasProfile = "has_profile";
  static const String accessToken = "access_token";
  static const String firstname = "firstname";
  static const String lastname = "lastname";
  static const String email = "email";
  static const String password = "password";
  static const String themeMode = "theme_mode";
}

sealed class Urls {
  Urls._();

  static const image = 'https://openweathermap.org/img/w/{id}.png';

  static const String currentAndForecast = "/data/3.0/onecall";
  static const String loginWithOption = "/v2/login/with-option";
  static const String register = "/v2/register";

  static const String objectSlim = "/v1/object-slim";
}

sealed class Slugs {
  Slugs._();

  static const String patients = "/patients";
}

sealed class DatabaseKeys {
  DatabaseKeys._();

  static const String categoryList = "category_list/";
  static const String guidList = "guid_list/";
  static const String article = "article/";
}
