
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetPopularTv getPopularTv;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getPopularTv = GetPopularTv(mockMovieRepository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockMovieRepository.getPopularTv())
                .thenAnswer((_) async => Right(tTvs));
            // act
            final result = await getPopularTv.execute();
            // assert
            expect(result, Right(tTvs));
          });
    });
  });

}