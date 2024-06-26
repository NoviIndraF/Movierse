
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movierse/domain/entities/movie.dart';
import 'package:movierse/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovie;

  NowPlayingMovieBloc(this.getNowPlayingMovie)
      : super(NowPlayingMovieInitial()) {
    on<GetNowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovie.execute();

      result.fold(
        (failure) {
          emit(NowPlayingMovieError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(NowPlayingMovieEmpty())
              : emit(GetNowPlayingMovieState(data));
        },
      );
    });
  }
}
