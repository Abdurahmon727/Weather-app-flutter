import "package:equatable/equatable.dart";

sealed class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    this.statusCode,
  });

  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({ super.message = 'No internet'});

  @override
  List<Object?> get props => <Object?>[];
}

class LocationNotPermitted extends Failure {
  LocationNotPermitted({super.message = 'No granted location'});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  @override
  List<Object?> get props => <Object?>[message];
}
