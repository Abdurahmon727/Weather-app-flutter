part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class Init extends HomeEvent {}

class GetForecast extends HomeEvent {}

class SetCity extends HomeEvent {
  SetCity(this.city);

  final CityModel city;

  @override
  List<Object?> get props => [city];
}
