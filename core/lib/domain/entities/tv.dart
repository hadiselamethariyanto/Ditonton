import 'package:equatable/equatable.dart';

class Tv extends Equatable {


  Tv(
      {required this.id,
      required this.posterPath,
      required this.popularity,
      required this.backdropPath,
      required this.voteAverage,
      required this.overview,
      required this.firstAirDate,
      required this.genreIds,
      required this.originalLanguage,
      required this.voteCount,
      required this.name,
      required this.originalName});

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  int id;
  String? posterPath;
  double? popularity;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? firstAirDate;
  List<int>? genreIds;
  String? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;



  @override
  List<Object?> get props => [
        id,
        posterPath,
        popularity,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName
      ];
}
