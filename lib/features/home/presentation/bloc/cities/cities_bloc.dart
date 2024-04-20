
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/home/data/model/city_model.dart';
import 'package:flutter_clean_architecture/features/home/domain/repository/repository.dart';

import '../../../../../core/domain/status.dart';

part 'cities_event.dart';

part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final HomeRepository repository;

  CitiesBloc(this.repository) : super(CitiesState()) {
    on<CitiesEventSearch>(_search);
  }

  void _search(
    CitiesEventSearch event,
    Emitter<CitiesState> emit,
  ) async {
    emit(state.copy(status: Status.loading));

    final data = await repository.searchCity(event.query);
    data.fold(
      (left) => emit(state.copy(status: Status.fail, message: left.message)),
      (right) => emit(state.copy(status: Status.success, cities: data.right)),
    );
  }
}
