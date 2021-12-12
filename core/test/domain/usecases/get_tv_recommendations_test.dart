import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations getTvRecommendations;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTvRecommendations = GetTvRecommendations(mockMovieRepository);
  });

  final tTvs = <Tv>[];
  const tId = 1;

  test(
      'should get list of tv from the repository when execute function is called',
      () async {
    // arrange
    when(mockMovieRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await getTvRecommendations.execute(tId);
    // assert
    expect(result, Right(tTvs));
  });
}
