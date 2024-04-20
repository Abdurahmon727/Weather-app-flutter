import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';
import 'package:flutter_clean_architecture/features/home/data/model/current_and_forecast_model.dart';

import '../../../../core/either/either.dart';

abstract class HomeRepository {
  Future<Either<Failure, CurrentAndForecastModel>> getCurrentAndForecast(double lat, double lon);
  Future<Either<Failure,List<CityModel>>> searchCity(String query);
}
