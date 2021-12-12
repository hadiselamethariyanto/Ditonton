import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv searchTv;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchTv = SearchTv(mockMovieRepository);
  });

  final tTvs = <Tv>[];
  const tQuery = 'One Piece';

  test(
      'should get list of tvs from the repository when execute function is called',
      () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await searchTv.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
