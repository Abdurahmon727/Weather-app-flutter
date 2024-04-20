part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({
    this.status = Status.pure,
    this.message = '',
    this.forecastModel,
  });

  final Status status;
  final String message;
  final CurrentAndForecastModel? forecastModel;

  HomeState copy(
          {Status? status,
          String? message,
          CurrentAndForecastModel? forecastModel}) =>
      HomeState(
        status: status ?? this.status,
        message: message ?? this.message,
        forecastModel: forecastModel ?? this.forecastModel,
      );

  @override
  List<Object> get props => [status, message];
}
