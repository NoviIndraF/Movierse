
import 'package:get_it/get_it.dart';
import 'package:movierse/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movierse/presentation/blocs/now_playing/now_playing_movie_bloc.dart';
import 'package:movierse/presentation/blocs/popular/popular_movie_bloc.dart';
import 'package:movierse/presentation/blocs/recomendation/recomendation_movie_bloc.dart';
import 'package:movierse/presentation/blocs/search/search_bloc.dart';
import 'package:movierse/presentation/blocs/top_rated/top_rated_movie_bloc.dart';
import 'package:movierse/presentation/blocs/watchlist/watchlist_movie_bloc.dart';
import 'core/security/ssl_pinning.dart';
import 'data/datasources/database/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'domain/usecases/get_movie_recommendations.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_top_rated_movies.dart';
import 'domain/usecases/get_watchlist_movies.dart';
import 'domain/usecases/get_watchlist_status.dart';
import 'domain/usecases/remove_watchlist.dart';
import 'domain/usecases/save_watchlist.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/search_movies.dart';

final locator = GetIt.instance;

void init() {
  // BLOC
  locator.registerFactory(
        () => SearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => DetailMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => NowPlayingMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TopRatedMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => PopularMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => RecomendationMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // USECASE
  // movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));


  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());


  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<SSLPinningClient>(() => SSLPinningClient());
}
