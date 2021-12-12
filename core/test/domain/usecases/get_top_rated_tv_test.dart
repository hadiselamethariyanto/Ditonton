import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv getTopRatedTv;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTopRatedTv = GetTopRatedTv(mockMovieRepository);
  });

  final tTvs = <Tv>[];

  group('GetTopRatedTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRepository.getTopRatedTv())
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await getTopRatedTv.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
