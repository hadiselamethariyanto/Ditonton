part of 'popular_tv_bloc.dart';

class PopularTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularTvHasData extends PopularTvState {
  final List<Tv> tv;

  PopularTvHasData(this.tv);

  @override
  List<Object?> get props => [tv];
}
