import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_state.dart';

part 'watchlist_tv_event.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchListTv saveWatchListTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final GetWatchListTv getWatchlistTvs;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvBloc(this.getWatchListStatus, this.saveWatchListTv,
      this.removeWatchlistTv, this.getWatchlistTvs)
      : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTvEvent>(
      (event, emit) async {
        emit(WatchlistTvLoading());
        final result = await getWatchlistTvs.execute();
        result.fold(
          (failure) {
            emit(WatchlistTvError(failure.message));
          },
          (data) {
            emit(WatchlistTvHasData(data));
          },
        );
      },
    );

    on<LoadWatchlistTvStatusEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      emit(WatchlistTvStatus(result));
    });

    on<AddWatchlistTvEvent>((event, emit) async {
      final tv = event.tv;
      final result = await saveWatchListTv.execute(tv);
      await result.fold(
        (failure) async {
          emit(WatchlistTvError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvMessage(successMessage));
        },
      );

      add(LoadWatchlistTvStatusEvent(event.tv.id));
    });

    on<RemoveWatchlistTvEvent>((event, emit) async {
      final tv = event.tv;
      final result = await removeWatchlistTv.execute(tv);
      await result.fold(
        (failure) async {
          emit(WatchlistTvError(failure.message));
        },
        (successMessage) async {
          emit(WatchlistTvMessage(successMessage));
        },
      );

      add(LoadWatchlistTvStatusEvent(event.tv.id));
    });
  }
}
