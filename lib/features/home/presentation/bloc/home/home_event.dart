part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class Init extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetForecast extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SetCity extends HomeEvent {
  SetCity(this.city);

  final CityModel city;

  @override
  List<Object?> get props => [city];
}
