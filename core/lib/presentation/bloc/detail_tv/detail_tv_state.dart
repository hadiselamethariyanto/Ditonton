part of 'detail_tv_bloc.dart';

class DetailTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailTvEmpty extends DetailTvState {}

class DetailTvLoading extends DetailTvState {}

class DetailTvError extends DetailTvState {
  final String message;

  DetailTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvRecommendationsLoading extends DetailTvState {}

class TvRecommendationsError extends DetailTvState {
  final String message;

  TvRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvHasData extends DetailTvState {
  final TvDetail tv;
  final List<Tv> tvRecommendations;

  DetailTvHasData(this.tv, this.tvRecommendations);

  @override
  List<Object?> get props => [tv, tvRecommendations];
}
