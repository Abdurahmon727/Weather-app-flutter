import 'package:dio/dio.dart';

extension StatusCode<T> on Response<T> {
  bool get isSuccessful =>
      (this.statusCode ?? 0) >= 200 && (this.statusCode ?? 0) < 300;

  bool get isUnAuthorized => (this.statusCode ?? 0) == 401;
}
