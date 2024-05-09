import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movierse/core/constant/constants.dart';
import 'package:movierse/core/routes/routes.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';
import 'package:movierse/domain/entities/movie.dart';
import 'package:movierse/presentation/blocs/now_playing/now_playing_movie_bloc.dart';
import 'package:movierse/presentation/blocs/popular/popular_movie_bloc.dart';
import 'package:movierse/presentation/blocs/top_rated/top_rated_movie_bloc.dart';
import 'package:movierse/presentation/widgets/item_card_movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: whiteColor,
          color: accentColor,
          onRefresh: (){
            return
            Future.microtask(() {
              context.read<NowPlayingMovieBloc>().add(const GetNowPlayingMovieEvent());
              context.read<PopularMovieBloc>().add(const GetPopularMovieEvent());
              context.read<TopRatedMovieBloc>().add(const GetTopRatedMovieEvent());
            });
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4, right: 12, left: 12),
                  child: Row(
                    children: [
                      Text(
                        'Hello, Novi Indra',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(
                              context,
                              PROFILE_ROUTE,
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/images/profile.jpeg'),
                            radius:  24,
                          ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'NOW PLAYING',
                          style: titleText.copyWith(),
                        ),
                      ),
                      BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                        builder: (context, state) {
                          if (state is NowPlayingMovieLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetNowPlayingMovieState) {
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: 400,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: state.result.map((movie) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          DETAIL_MOVIE_ROUTE,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '$BASE_IMAGE_URL${movie.posterPath}',
                                            fit: BoxFit.cover,
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
                                );
                              }).toList(),
                            );
                          } else if (state is NowPlayingMovieError) {
                            return Center(
                              key: Key('error_message'),
                              child: Text(state.message),
                            );
                          } else {
                            return Expanded(
                              child: Container(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Top Rated',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      Text(
                        'See More',
                        style: titleText.copyWith(color: accentColor),
                      )
                    ],
                  ),
                ),
                BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                    builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetTopRatedMovieState) {
                    return TopRatedListMovie(state.result);
                  } else if (state is TopRatedMovieError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                }),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Popular',
                        style: titleText.copyWith(),
                      ),
                      Spacer(),
                      Text(
                        'See More',
                        style: titleText.copyWith(color: accentColor),
                      )
                    ],
                  ),
                ),
                BlocBuilder<PopularMovieBloc, PopularMovieState>(
                    builder: (context, state) {
                  if (state is PopularMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (state is GetPopularMovieState) {
                    return PopularListMovie(state.result);
                  }
                  else if (state is PopularMovieError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopRatedListMovie extends StatelessWidget {
  final List<Movie> movies;

  TopRatedListMovie(this.movies);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ItemCardMovie(movie);
        },
        itemCount: movies.length,
      ),
    );
  }
}

class PopularListMovie extends StatelessWidget {
  final List<Movie> movies;

  PopularListMovie(this.movies);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < (movies.length / 2).ceil(); i++)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: i * 2 < movies.length
                      ? ItemCardMovie(movies[i * 2])
                      : SizedBox(), // Untuk menangani data ganjil terakhir
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: (i * 2 + 1 < movies.length)
                      ? ItemCardMovie(movies[i * 2 + 1])
                      : SizedBox(), // Untuk menangani data ganjil terakhir
                ),
              ),
            ],
          ),
      ],
    );
  }
}
