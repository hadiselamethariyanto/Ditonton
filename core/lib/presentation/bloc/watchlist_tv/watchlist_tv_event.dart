part of 'watchlist_tv_bloc.dart';

class WatchlistTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWatchlistTvStatusEvent extends WatchlistTvEvent {
  final int id;

  LoadWatchlistTvStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchWatchlistTvEvent extends WatchlistTvEvent {
  @override
  List<Object?> get props => [];
}

class AddWatchlistTvEvent extends WatchlistTvEvent {
  final TvDetail tv;

  AddWatchlistTvEvent(this.tv);

  @override
  List<Object?> get props => [tv];
}

class RemoveWatchlistTvEvent extends WatchlistTvEvent {
  final TvDetail tv;

  RemoveWatchlistTvEvent(this.tv);

  @override
  List<Object?> get props => [tv];
}
