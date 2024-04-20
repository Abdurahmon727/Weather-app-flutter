part of 'home_bloc.dart';

class HomeState extends Equatable {
  HomeState({
    this.status = Status.pure,
    this.message = '',
  });

  final Status status;
  final String message;

  HomeState copy({
    Status? status,
    String? message,
  }) =>
      HomeState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [status, message];
}
