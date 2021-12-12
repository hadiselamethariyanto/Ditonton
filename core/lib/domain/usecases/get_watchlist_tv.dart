import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

class GetWatchListTv {
  final MovieRepository _repository;

  GetWatchListTv(this._repository);

  Future<Either<Failure,List<Tv>>> execute(){
    return _repository.getWatchlistTv();
  }
}