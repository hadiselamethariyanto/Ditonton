part of 'watchlist_movie_bloc.dart';

class WatchlistMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchlistMovieEvent extends WatchlistMovieEvent {
  @override
  List<Object?> get props => [];
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddWatchlistMovie(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveWatchlistMovie(this.movie);

  @override
  List<Object?> get props => [movie];
}
