import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchListStatus, SaveWatchlist, RemoveWatchlist, GetWatchlistMovies])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;
  const tId = 1;
  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchListStatus,
        mockSaveWatchlist, mockRemoveWatchlist, mockGetWatchlistMovies);
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return [WatchlistStatus] when get watchlist status success',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WatchlistStatus(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return [Message] when add wathclist success',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) {
      bloc.add(AddWatchlistMovie(testMovieDetail));
      bloc.add(LoadWatchlistStatus(tId));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [WatchlistMessage('Success'), WatchlistStatus(true)],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return [Error] when add watchlist status unsuccessfull',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) {
      bloc.add(AddWatchlistMovie(testMovieDetail));
      bloc.add(LoadWatchlistStatus(tId));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistMovieError('Database Failure'),
      WatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return [Message] when remove watchlist success',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [WatchlistMessage('Removed'), WatchlistStatus(true)],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return [Error] when remove watchlist unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistMovieError('Database Failure'),
      WatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return [Has Data] when fetch watchlist success',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [WatchlistMovieLoading(), WatchlistMovieHasData(tMovieList)],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return [Loading, Error] when fetch watchlist unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovieEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
