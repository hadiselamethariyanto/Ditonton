part of 'tv_search_bloc.dart';

class TvSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvSearchEmpty extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchError extends TvSearchState {
  final String message;

  TvSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSearchHasData extends TvSearchState {
  final List<Tv> tv;

  TvSearchHasData(this.tv);

  @override
  List<Object?> get props => [tv];
}
