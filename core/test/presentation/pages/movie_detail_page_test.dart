import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMoviesBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class MockDetailMovieEvent extends Fake implements DetailMovieEvent {}

class MockDetailMovieState extends Fake implements DetailMovieState {}

class MockWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class MockWatchlistMovieState extends Fake implements WatchlistMovieState {}

void main() {
  late MockDetailMoviesBloc mockDetailMoviesBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    registerFallbackValue(MockDetailMovieEvent());
    registerFallbackValue(MockDetailMovieState());
    registerFallbackValue(MockWatchlistMovieEvent());
    registerFallbackValue(MockWatchlistMovieState());
  });

  setUp(() {
    mockDetailMoviesBloc = MockDetailMoviesBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (_) => mockDetailMoviesBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => mockWatchlistMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      when(() => mockDetailMoviesBloc.add(GetDetailMovieEvent(1)))
          .thenAnswer((_) async => {});
      when(() => mockDetailMoviesBloc.state).thenAnswer(
          (_) => DetailMovieHasData(testMovieDetail, testMovieList));
      when(() => mockWatchlistMoviesBloc.add(LoadWatchlistStatus(1)))
          .thenAnswer((_) async => {});

      when(() => mockWatchlistMoviesBloc.state)
          .thenAnswer((_) => const WatchlistStatus(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.add(GetDetailMovieEvent(1)))
        .thenAnswer((_) => {});
    when(() => mockDetailMoviesBloc.state)
        .thenAnswer((_) => DetailMovieHasData(testMovieDetail, testMovieList));

    when(() => mockWatchlistMoviesBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => const WatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.add(GetDetailMovieEvent(1)))
        .thenAnswer((_) async => {});
    when(() => mockDetailMoviesBloc.state)
        .thenAnswer((_) => DetailMovieHasData(testMovieDetail, testMovieList));

    when(() => mockWatchlistMoviesBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(() => mockWatchlistMoviesBloc.state)
        .thenAnswer((_) => const WatchlistStatus(false));

    whenListen(mockWatchlistMoviesBloc,
        Stream.fromIterable([WatchlistMessage('Added to Watchlist')]));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.add(GetDetailMovieEvent(1)))
        .thenAnswer((_) async => {});
    when(() => mockDetailMoviesBloc.state)
        .thenAnswer((_) => DetailMovieHasData(testMovieDetail, testMovieList));

    when(() => mockWatchlistMoviesBloc.add(LoadWatchlistStatus(1)))
        .thenAnswer((_) async => {});
    when(()=> mockWatchlistMoviesBloc.state).thenAnswer((_) => const WatchlistStatus(false));

    whenListen(mockWatchlistMoviesBloc,
        Stream.fromIterable([WatchlistMessage('Failed Watchlist')]));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed Watchlist'), findsOneWidget);
  });
}
