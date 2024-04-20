import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/either/either.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';

import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/home/data/data_source/remote_data_source.dart';

import 'package:flutter_clean_architecture/features/home/data/model/CurrentAndForecastModel.dart';
import 'package:flutter_clean_architecture/router/app_routes.dart';

import '../../../../constants/constants.dart';
import '../../../../core/connectivity/network_info.dart';
import '../../domain/repository/repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(
      NetworkInfo networkInfo, HomeRemoteDataSource remoteDataSource) {
    _networkInfo = networkInfo;
    _remoteDataSource = remoteDataSource;
  }

  late final NetworkInfo _networkInfo;
  late final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, CurrentAndForecastModel>> getCurrentAndForecast(
      double lat, double lon) async {
    if (await _networkInfo.isConnected) {
      try {
        final data = await _remoteDataSource.getForecast(lat, lon);
        await localSource.setCache(Urls.currentAndForecast, jsonEncode(data));
        return Right(data);
      } catch (e) {
        debugPrint('Error on fetching ${Urls.currentAndForecast}: $e');
        if (e is ServerException)
          return Left(ServerFailure(message: e.message));
        return Left(ServerFailure(message: 'Something went wrong'));
      }
    } else {
      final cache = await localSource.getCache(Urls.currentAndForecast);
      if (cache.isEmpty) return Left(CacheFailure(message: 'No cached data'));
      return Right(
        CurrentAndForecastModel.fromJson(jsonDecode(cache)),
      );
    }
  }
}
