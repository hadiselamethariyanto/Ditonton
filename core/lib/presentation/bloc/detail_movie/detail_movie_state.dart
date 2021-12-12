part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object?> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieError extends DetailMovieState {
  final String message;

  DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsLoading extends DetailMovieState{}

class MovieRecommendationsError extends DetailMovieState{
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail movie;
  final List<Movie> movieRecommendations;

  DetailMovieHasData(this.movie, this.movieRecommendations);

  @override
  List<Object> get props => [movie, movieRecommendations];
}
