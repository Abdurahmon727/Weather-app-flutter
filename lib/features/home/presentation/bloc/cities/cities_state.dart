part of 'cities_bloc.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();
}

final class CitiesInitial extends CitiesState {
  @override
  List<Object> get props => [];
}
