import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/either/either.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';
import 'package:flutter_clean_architecture/features/home/data/model/current_and_forecast_model.dart';
import 'package:flutter_clean_architecture/features/home/domain/repository/repository.dart';
import 'package:flutter_clean_architecture/router/app_routes.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../constants/constants.dart';
import '../../../../../core/domain/status.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeState()) {
    on<Init>(_init);
    on<GetForecast>(_onGetForecast);
    on<SetCity>(_setCity);
  }

  Future<void> _init(
    Init event,
    Emitter<HomeState> emit,
  ) async {
    final cachedCity = await localSource.getCache(AppKeys.city);
    if (cachedCity.isNotEmpty) {
      emit(
        state.copy(city: CityModel.fromJson(jsonDecode(cachedCity))),
      );
    }
    await _onGetForecast(GetForecast(), emit);
  }

  Future<void> _onGetForecast(
    GetForecast event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copy(status: Status.loading));

    if (state.city != null) {
      final city = state.city!;
      final data = await repository.getCurrentAndForecast(
          (city.lat ?? 0).toDouble(), (city.lon ?? 0).toDouble());

      data.fold(
        (left) => emit(state.copy(status: Status.fail, message: left.message)),
        (right) => emit(state.copy(
          status: Status.success,
          forecastModel: right,
        )),
      );

      return;
    }

    final location = await _determinePosition();
    if (location.isLeft) {
      emit(state.copy(status: Status.fail, message: location.left.message));
      return;
    }

    final position = location.right;
    final data = await repository.getCurrentAndForecast(
        position.latitude, position.longitude);

    data.fold(
      (left) => emit(state.copy(status: Status.fail, message: left.message)),
      (right) => emit(
        state.copy(
          status: Status.success,
          forecastModel: right,
        ),
      ),
    );
  }

  Future<void> _setCity(
    SetCity event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copy(city: event.city));
    await localSource.setCache(AppKeys.city, jsonEncode(event.city));
    await _onGetForecast(GetForecast(), emit);
  }

  Future<Either<Failure, Position>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(LocationNotPermitted());
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Left(LocationNotPermitted());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Left(LocationNotPermitted(
          message:
              'Location permissions are permanently denied, we cannot request permissions.'));
    }

    return Right(await Geolocator.getCurrentPosition());
  }
}
