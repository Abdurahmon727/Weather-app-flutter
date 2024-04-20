part of 'cities_bloc.dart';

class CitiesState extends Equatable {
  CitiesState({
    this.status = Status.pure,
    this.message = '',
    this.cities,
  });

  final Status status;
  final String message;
  final List<CityModel>? cities;

  CitiesState copy(
          {Status? status, String? message, List<CityModel>? cities}) =>
      CitiesState(
        status: status ?? this.status,
        message: message ?? this.message,
        cities: cities ?? this.cities,
      );

  @override
  List<Object?> get props => [status, message, cities];
}
