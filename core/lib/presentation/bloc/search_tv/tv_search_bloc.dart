import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;

  TvSearchBloc(this.searchTv) : super(TvSearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(TvSearchLoading());
        final result = await searchTv.execute(query);
        result.fold(
          (failure) {
            emit(TvSearchError(failure.message));
          },
          (data) {
            emit(TvSearchHasData(data));
          },
        );
      },
    );
  }
}
