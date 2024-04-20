part of 'cities_bloc.dart';

abstract class CitiesEvent extends Equatable {
  const CitiesEvent();
}

class CitiesEventSearch extends CitiesEvent {
  CitiesEventSearch(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
