part of 'on_the_air_bloc.dart';

abstract class OnTheAirState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnTheAirEmpty extends OnTheAirState {}

class OnTheAirLoading extends OnTheAirState {}

class OnTheAirError extends OnTheAirState {
  final String message;

  OnTheAirError(this.message);

  @override
  List<Object?> get props => [message];
}

class OnTheAirHasData extends OnTheAirState {
  final List<Tv> tv;

  OnTheAirHasData(this.tv);

  @override
  List<Object?> get props => [tv];
}
