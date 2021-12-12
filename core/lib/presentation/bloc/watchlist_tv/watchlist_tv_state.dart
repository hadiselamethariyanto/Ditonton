part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> tv;

  WatchlistTvHasData(this.tv);

  @override
  List<Object?> get props => [tv];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvStatus extends WatchlistTvState {
  final bool isAddedToWatchlist;

  WatchlistTvStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class WatchlistTvMessage extends WatchlistTvState {
  final String watchlistMessage;

  WatchlistTvMessage(this.watchlistMessage);

  @override
  List<Object?> get props => [watchlistMessage];
}
