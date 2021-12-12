import 'package:core/data/models/season_model.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  final String? backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<SeasonModel>? seasons;
  final String status;
  final double voteAverage;
  final int voteCount;

  TvDetailResponse(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.name,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.seasons,
      required this.status,
      required this.voteAverage,
      required this.voteCount});

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
          backdropPath: json["backdrop_path"],
          firstAirDate: json["first_air_date"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          homepage: json["homepage"],
          id: json["id"],
          name: json["name"],
          numberOfEpisodes: json["number_of_episodes"],
          numberOfSeasons: json["number_of_seasons"],
          originalLanguage: json["original_language"],
          originalName: json["original_name"],
          overview: json["overview"],
          popularity: json["popularity"].toDouble(),
          posterPath: json["poster_path"],
          seasons: List<SeasonModel>.from(
              json["seasons"].map((x) => SeasonModel.fromJson(x))),
          status: json["status"],
          voteAverage: json["vote_average"].toDouble(),
          voteCount: json["vote_count"]);

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homepage: homepage,
        id: id,
        name: name,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        seasons: this.seasons!.map((season) => season.toEntity()).toList(),
        status: status,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        voteAverage,
        voteCount
      ];
}
