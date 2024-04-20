import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/constants/constants.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/extension/status_code.dart';
import 'package:flutter_clean_architecture/features/home/data/model/CurrentAndForecastModel.dart';

abstract class HomeRemoteDataSource {
  Future<CurrentAndForecastModel> getForecast(double lat, double lon);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<CurrentAndForecastModel> getForecast(double lat, double lon) async {
    final response = await dio.get(
      Constants.baseUrl + Urls.currentAndForecast,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appId': Constants.apiKey,
        'units':'metric'
      },
    );

    if (response.isSuccessful) {
      return CurrentAndForecastModel.fromJson(response.data);
    } else {
      throw ServerException(message: 'Server down :(');
    }
  }
}
