

import 'package:dartz/dartz.dart';
import 'package:movierse/core/handling/failure.dart';
import 'package:movierse/domain/entities/movie.dart';
import 'package:movierse/domain/repositories/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
