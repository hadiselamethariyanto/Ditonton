import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';

part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  DetailTvBloc(this.getTvDetail, this.getTvRecommendations)
      : super(DetailTvEmpty()) {
    on<GetDetailTvEvent>(
      (event, emit) async {
        final id = event.id;

        emit(DetailTvLoading());
        final result = await getTvDetail.execute(id);
        final recommendations = await getTvRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(DetailTvError(failure.message));
          },
          (tv) {
            emit(TvRecommendationsLoading());
            recommendations.fold(
              (failure) {
                emit(TvRecommendationsError(failure.message));
              },
              (tvRecommendations) {
                emit(DetailTvHasData(tv, tvRecommendations));
              },
            );
          },
        );
      },
    );
  }
}
