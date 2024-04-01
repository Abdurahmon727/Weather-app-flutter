import "dart:io";

sealed class Constants {
  Constants._();

  static const String authUrl = "https://api.auth.u-code.io";
  static const String baseUrl = "https://api.admin.u-code.io";

  /// id
  static const String clientTypeId = "f312b956-e6b3-4b45-aa1c-c9d717b3d42f";
  static const String companyId = "07660ee4-78fc-4709-badb-bca9897070a1";
  static const String roleId = "81a2b429-fe32-4781-adf5-aacc94c5ef45";

  static final String appLink = Platform.isIOS
      ? "https://apps.apple.com/us/app/q-watt-powerbank-sharing/id6444178516"
      : "https://play.google.com/store/apps/details?id=com.q.watt";
}

class Validations {
  Validations._();

  static const String emailEmpty = "Email cannot be empty";
  static const String notEmail = "This is not email";
  static const String passwordEmpty = "Password cannot be empty";
  static const String passwordShort = "Password too short";
  static const String passwordLong = "Password too long";
  static const String firstnameEmpty = "Firstname cannot be empty";
  static const String firstnameShort = "Firstname too short";
  static const String firstnameLong = "Firstname too long";
  static const String lastnameEmpty = "Last name cannot be empty";
  static const String lastnameShort = "Lastname too short";
  static const String lastnameLong = "Lastname too long";
  static const String passwordNotMatch = "Passwords do not match";
  static const String internetFailure = "No Internet";
  static const String somethingWentWrong = "Something went wrong!";
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

  static const String sendCode = "/v2/send-code";
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
