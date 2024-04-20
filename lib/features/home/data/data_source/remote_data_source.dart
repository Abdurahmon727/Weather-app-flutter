
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/constants/constants.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/extension/status_code.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';
import 'package:flutter_clean_architecture/features/home/data/model/current_and_forecast_model.dart';

abstract class HomeRemoteDataSource {
  Future<CurrentAndForecastModel> getForecast(double lat, double lon);

  Future<List<CityModel>> searchCity(String query);
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
        'units': 'metric'
      },
    );

    if (response.isSuccessful) {
      return CurrentAndForecastModel.fromJson(response.data);
    } else {
      throw ServerException(message: 'Server down :(');
    }
  }

  @override
  Future<List<CityModel>> searchCity(String query) async {
    final response = await dio.get(
      Constants.baseUrl + Urls.geoSearch,
      queryParameters: {
        'q': query,
        'limit':20,
        'appId': Constants.apiKey,
      },
    );

    if (response.isSuccessful) {
      return (response.data as List).map((e) => CityModel.fromJson(e)).toList();
    } else {
      throw ServerException(message: 'Server down :(');
    }
  }
}
