import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movierse/core/constant/constants.dart';
import 'package:movierse/core/routes/routes.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';
import 'package:movierse/domain/entities/genre.dart';
import 'package:movierse/domain/entities/movie.dart';
import 'package:movierse/domain/entities/movie_detail.dart';
import 'package:movierse/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movierse/presentation/blocs/recomendation/recomendation_movie_bloc.dart';
import 'package:movierse/presentation/blocs/watchlist/watchlist_movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(GetMovieDetailEvent(widget.id));
      context
          .read<RecomendationMovieBloc>()
          .add(GetMovieRecomendationEvent(widget.id));
      context
          .read<WatchlistMovieBloc>()
          .add(GetMovieWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final recomendationMovieState =
        context.watch<RecomendationMovieBloc>().state;
    bool isAddedToWatchlist = context.select<WatchlistMovieBloc, bool>(
        (value) => (value.state is GetMovieWatchlistStatusState)
            ? (value.state as GetMovieWatchlistStatusState).result
            : false);

    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetDetailMovieState) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(
                movie,
                recomendationMovieState is GetRecomendationMovieState
                    ? recomendationMovieState.result
                    : [],
                isAddedToWatchlist,
              ),
            );
          } else if (state is DetailMovieError) {
            return Text(state.message);
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: titleText,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Genres : ' +
                                            showGenres(widget.movie.genres),
                                      ),
                                      Text(
                                        'Duration : ' +
                                            showDuration(widget.movie.runtime),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${widget.movie.voteAverage}',
                                        style: titleText,
                                        overflow: TextOverflow.clip,
                                      ),
                                      SizedBox(height: 4),
                                      RatingBarIndicator(
                                        rating: widget.movie.voteAverage / 2,
                                        itemCount: 5,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: accentColor,
                                        ),
                                        itemSize: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Release Date : ' +
                                  widget.movie.releaseDate,
                              style: subtitleText,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: normalText,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: normalText,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = widget.recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          DETAIL_MOVIE_ROUTE,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: GestureDetector(
            onTap: () async {
              if (!widget.isAddedWatchlist) {
                context
                    .read<WatchlistMovieBloc>()
                    .add(SaveWatchlistMovieEvent(widget.movie));
              } else {
                context
                    .read<WatchlistMovieBloc>()
                    .add(RemoveWatchlistMovieEvent(widget.movie));
              }
              final state = BlocProvider.of<WatchlistMovieBloc>(context).state;
              String msg = "";

              if (state is SavedWatchlistMovieState) {
                final isAdded = state.result;
                msg = isAdded == false ? ADD_SUCCESS : REMOVE_SUCCESS;
              } else {
                msg = !widget.isAddedWatchlist ? ADD_SUCCESS : REMOVE_SUCCESS;
              }

              if (msg == ADD_SUCCESS || msg == REMOVE_SUCCESS) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(msg)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(msg),
                      );
                    });
              }

              setState(() {
                widget.isAddedWatchlist = !widget.isAddedWatchlist;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor,
              ),
              child: widget.isAddedWatchlist
                  ? Icon(
                      Icons.bookmark_added,
                      size: 40,
                      color: whiteColor,
                    )
                  : Icon(
                      Icons.bookmark_border,
                      size: 40,
                      color: whiteColor,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  String showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
