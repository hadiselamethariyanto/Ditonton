part of '../watchlist_movie/watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String error;

  const WatchlistMovieError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movie;

  WatchlistMovieHasData(this.movie);

  @override
  List<Object?> get props => [movie];
}

class WatchlistStatus extends WatchlistMovieState {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class WatchlistMessage extends WatchlistMovieState {
  final String watchlistMessage;

  const WatchlistMessage(this.watchlistMessage);

  @override
  List<Object?> get props => [watchlistMessage];
}
