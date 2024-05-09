


import 'package:dartz/dartz.dart';
import 'package:movierse/core/handling/failure.dart';
import 'package:movierse/domain/entities/movie_detail.dart';
import 'package:movierse/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
