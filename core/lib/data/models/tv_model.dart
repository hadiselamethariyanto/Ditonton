import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  final int id;
  final String? posterPath;
  final double popularity;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  TvModel(
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

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      id: json['id'],
      posterPath: json['poster_path'],
      popularity: json['popularity'].toDouble(),
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      overview: json['overview'],
      firstAirDate: json['first_air_date'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      originalLanguage: json['original_language'],
      voteCount: json['vote_count'],
      name: json['name'],
      originalName: json['original_name']);

  Tv toEntity() {
    return Tv(
        id: this.id,
        posterPath: this.posterPath,
        popularity: this.popularity,
        backdropPath: this.backdropPath,
        voteAverage: this.voteAverage,
        overview: this.overview,
        firstAirDate: this.firstAirDate,
        genreIds: this.genreIds,
        originalLanguage: this.originalLanguage,
        voteCount: this.voteCount,
        name: this.name,
        originalName: this.originalName);
  }

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
