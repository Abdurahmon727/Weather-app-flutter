import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  CitiesBloc() : super(CitiesInitial()) {
    on<CitiesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
