import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_event.dart';

part '../watchlist_movie/watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistMovieBloc(this.getWatchListStatus, this.saveWatchlist,
      this.removeWatchlist, this.getWatchlistMovies)
      : super(WatchlistMovieEmpty()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      emit(WatchlistStatus(result));
    });

    on<AddWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      final result = await saveWatchlist.execute(movie);
      result.fold(
        (failure)  {
          emit(WatchlistMovieError(failure.message));
        },
        (successMessage)  {
          emit(WatchlistMessage(successMessage));
        },
      );

      add(LoadWatchlistStatus(event.movie.id));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      final result = await removeWatchlist.execute(movie);
      await result.fold(
        (failure) async {
          emit(WatchlistMovieError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMessage(successMessage));
        },
      );

      add(LoadWatchlistStatus(event.movie.id));
    });

    on<FetchWatchlistMovieEvent>(
      (event, emit) async {
        emit(WatchlistMovieLoading());
        final result = await getWatchlistMovies.execute();
        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (data) {
            emit(WatchlistMovieHasData(data));
          },
        );
      },
    );
  }
}
