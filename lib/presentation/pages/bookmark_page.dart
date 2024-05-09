import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';
import 'package:movierse/core/utils/utils.dart';
import 'package:movierse/presentation/blocs/watchlist/watchlist_movie_bloc.dart';
import 'package:movierse/presentation/widgets/item_watchlist_movie_card.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMovieBloc>().add(const GetWatchlistMovieEvent()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() =>
        context.read<WatchlistMovieBloc>().add(const GetWatchlistMovieEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Movie',
          style: titleText.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: whiteColor,
        color: accentColor,
        onRefresh: () {
          return Future.microtask(() {
            context
                .read<WatchlistMovieBloc>()
                .add(const GetWatchlistMovieEvent());
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
              if (state is WatchlistMovieLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetWatchlistMovieState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return WatchlistMovieCard(movie);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is WatchlistMovieError) {
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
