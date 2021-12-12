import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_on_the_air.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_event.dart';

part 'on_the_air_state.dart';

class OnTheAirBloc extends Bloc<OnTheAirEvent, OnTheAirState> {
  final GetTvOnTheAir getTvOnTheAir;

  OnTheAirBloc(this.getTvOnTheAir) : super(OnTheAirEmpty()) {
    on<GetOnTheAirTvEvent>(
      (event, emit) async {
        emit(OnTheAirLoading());
        final result = await getTvOnTheAir.execute();
        result.fold(
          (failure) {
            emit(OnTheAirError(failure.message));
          },
          (data) {
            emit(OnTheAirHasData(data));
          },
        );
      },
    );
  }
}
