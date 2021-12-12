import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailResponseModel = MovieDetailResponse(
    adult: true,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    imdbId: '1',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 1,
    voteCount: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "adult": true,
        "backdrop_path": 'backdropPath',
        "budget": 1,
        "genres": [{'id': 1, 'name': 'Action'}],
        "homepage": 'homepage',
        "id": 1,
        "imdb_id": '1',
        "original_language": 'originalLanguage',
        "original_title": 'originalTitle',
        "overview": 'overview',
        "popularity": 1.0,
        "poster_path": 'posterPath',
        "release_date": 'releaseDate',
        "revenue": 1,
        "runtime": 1,
        "status": 'status',
        "tagline": 'tagline',
        "title": 'title',
        "video": true,
        "vote_average": 1,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
