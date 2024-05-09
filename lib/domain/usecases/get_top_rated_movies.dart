import 'package:dartz/dartz.dart';
import 'package:movierse/core/handling/failure.dart';
import 'package:movierse/domain/entities/movie.dart';
import 'package:movierse/domain/repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
