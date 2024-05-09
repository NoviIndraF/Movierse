import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movierse/core/routes/routes.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/presentation/blocs/now_playing/now_playing_movie_bloc.dart';
import 'package:movierse/presentation/blocs/popular/popular_movie_bloc.dart';
import 'package:movierse/presentation/blocs/top_rated/top_rated_movie_bloc.dart';
import 'package:movierse/presentation/pages/bookmark_page.dart';
import 'package:movierse/presentation/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(const GetNowPlayingMovieEvent());
      context.read<PopularMovieBloc>().add(const GetPopularMovieEvent());
      context.read<TopRatedMovieBloc>().add(const GetTopRatedMovieEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      body: body(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          isExtended: true,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(
              context,
              SEARCH_MOVIE_ROUTE,
            );
          },
          child: Icon(Icons.search, color: accentColor,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }

  body() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return BookmarkPage();
      default:
        return HomePage();
    }
  }

  Padding buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: BottomNavigationBar(
            backgroundColor: bgCard,
            currentIndex: currentIndex,
            onTap: (value) {
              print(value);
              setState(() {
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Icon(
                      Icons.home_sharp,
                      color: currentIndex == 0 ? accentColor : whiteColor,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Icon(
                    Icons.bookmark,
                    color: currentIndex == 1 ? accentColor : whiteColor,
                  ),
                ),
                label: '',
              ),
            ]),
      ),
    );
  }
}
