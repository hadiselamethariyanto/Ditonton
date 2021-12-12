import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_on_the_air.dart';
import 'package:core/presentation/bloc/tv_list/on_the_air_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetTvOnTheAir])
void main() {
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late OnTheAirBloc onTheAirBloc;
  final tvModel = Tv(
      id: 31917,
      posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      popularity: 47.432451,
      backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
      voteAverage: 5.04,
      overview:
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      firstAirDate: "2010-06-08",
      genreIds: [18, 9648],
      originalLanguage: "en",
      voteCount: 133,
      name: "Pretty Little Liars",
      originalName: "Pretty Little Liars");
  final tTvList = <Tv>[tvModel];

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    onTheAirBloc = OnTheAirBloc(mockGetTvOnTheAir);
  });

  blocTest<OnTheAirBloc, OnTheAirState>(
    'Should return [Loading, HasData] when on the air success',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => Right(tTvList));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(GetOnTheAirTvEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [OnTheAirLoading(), OnTheAirHasData(tTvList)],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );

  blocTest<OnTheAirBloc, OnTheAirState>(
      'should return [Loading, Error] when on the air unsuccessful',
      build: () {
        when(mockGetTvOnTheAir.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirBloc;
      },
      act: (bloc) => bloc.add(GetOnTheAirTvEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [OnTheAirLoading(), OnTheAirError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvOnTheAir.execute());
      });
}
