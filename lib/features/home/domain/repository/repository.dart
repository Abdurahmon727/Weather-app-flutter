import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/home/data/model/CurrentAndForecastModel.dart';

import '../../../../core/either/either.dart';

abstract class HomeRepository {
  Future<Either<Failure, CurrentAndForecastModel>> getCurrentAndForecast(double lat, double lon);
}
