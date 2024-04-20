part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({
    this.status = Status.pure,
    this.message = '',
    this.forecastModel,
    this.city,
  });

  final Status status;
  final String message;
  final CurrentAndForecastModel? forecastModel;
  final CityModel? city;

  HomeState copy({
    Status? status,
    String? message,
    CurrentAndForecastModel? forecastModel,
    CityModel? city,
  }) =>
      HomeState(
        status: status ?? this.status,
        message: message ?? this.message,
        forecastModel: forecastModel ?? this.forecastModel,
        city: city ?? this.city,
      );

  @override
  List<Object?> get props => [status, message, forecastModel, city];
}
