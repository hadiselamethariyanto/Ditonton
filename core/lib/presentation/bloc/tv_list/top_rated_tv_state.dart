part of 'top_rated_tv_bloc.dart';

class TopRatedTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> tv;

  TopRatedTvHasData(this.tv);

  @override
  List<Object?> get props => [tv];
}
