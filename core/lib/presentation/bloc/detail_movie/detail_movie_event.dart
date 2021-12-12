part of 'detail_movie_bloc.dart';

class DetailMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final int id;

  GetDetailMovieEvent(this.id);

  @override
  List<Object?> get props => [id];
}
