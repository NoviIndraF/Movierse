import 'package:dartz/dartz.dart';
import 'package:movierse/core/handling/failure.dart';
import 'package:movierse/domain/entities/movie_detail.dart';
import 'package:movierse/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
