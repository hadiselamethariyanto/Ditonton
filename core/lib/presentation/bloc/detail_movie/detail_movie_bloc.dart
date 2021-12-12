import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  DetailMovieBloc(this.getMovieDetail, this.getMovieRecommendations)
      : super(DetailMovieEmpty()) {
    on<GetDetailMovieEvent>(
      (event, emit) async {
        final id = event.id;

        emit(DetailMovieLoading());
        final result = await getMovieDetail.execute(id);
        final recomendations = await getMovieRecommendations.execute(id);

        result.fold(
          (failure) {
            emit(DetailMovieError(failure.message));
          },
          (data) {
            emit(MovieRecommendationsLoading());
            recomendations.fold(
              (failure) {
                emit(DetailMovieError(failure.message));
              },
              (recomendations) {
                emit(DetailMovieHasData(data, recomendations));
              },
            );
          },
        );
      },
    );
  }
}
