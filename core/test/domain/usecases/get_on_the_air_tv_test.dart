import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_on_the_air.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvOnTheAir getTvOnTheAir;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTvOnTheAir = GetTvOnTheAir(mockMovieRepository);
  });

  final tTvs = <Tv>[];

  group('GetTvOnTheAir Tests', () {
    group('execute', () {
      test(
          'should get list of tvs from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRepository.getTvOnTheAir())
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await getTvOnTheAir.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
