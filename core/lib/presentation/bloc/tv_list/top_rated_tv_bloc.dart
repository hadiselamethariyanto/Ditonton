import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<GetTopRatedTvEvent>(
      (event, emit) async {
        emit(TopRatedTvLoading());
        final result = await getTopRatedTv.execute();
        result.fold(
          (failure) {
            emit(TopRatedTvError(failure.message));
          },
          (data) {
            emit(TopRatedTvHasData(data));
          },
        );
      },
    );
  }
}
