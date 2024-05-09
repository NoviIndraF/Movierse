import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movierse/presentation/blocs/now_playing/now_playing_movie_bloc.dart';
import 'package:movierse/presentation/blocs/popular/popular_movie_bloc.dart';
import 'package:movierse/presentation/blocs/recomendation/recomendation_movie_bloc.dart';
import 'package:movierse/presentation/blocs/search/search_bloc.dart';
import 'package:movierse/presentation/blocs/top_rated/top_rated_movie_bloc.dart';
import 'package:movierse/presentation/blocs/watchlist/watchlist_movie_bloc.dart';
import 'package:movierse/presentation/pages/detail_page.dart';
import 'package:movierse/presentation/pages/main_page.dart';
import 'package:movierse/injection.dart' as di;
import 'package:movierse/presentation/pages/profile_page.dart';
import 'package:movierse/presentation/pages/search_page.dart';

import 'core/routes/routes.dart';
import 'core/styles/texts.dart';
import 'core/utils/utils.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<DetailMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<NowPlayingMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<TopRatedMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<PopularMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<RecomendationMovieBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SearchBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<WatchlistMovieBloc>(),
          ),
        ],
        child: MaterialApp(
          title: 'Movierse',
          theme: ThemeData.dark().copyWith(
            colorScheme: colorScheme,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: primaryColor,
            textTheme: textTheme,
          ),
          debugShowCheckedModeBanner: false,
          home: Body(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case MAIN_ROUTE:
                return MaterialPageRoute(builder: (_) => MainPage());
              case DETAIL_MOVIE_ROUTE:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case PROFILE_ROUTE:
                return MaterialPageRoute(builder: (_) => ProfilePage());
              case SEARCH_MOVIE_ROUTE:
                return MaterialPageRoute(builder: (_) => SearchPage());
              default:
                return MaterialPageRoute(builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ));
  }

  Body() {
    switch (currentIndex) {
      case 0:
        return MainPage();
      default:
        return MainPage();
    }
  }

  Padding buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          // Set the desired background color here
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
                  color: currentIndex == 0 ? accentColor : Colors.white,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Icon(
                  Icons.safety_check,
                  color: currentIndex == 1 ? accentColor : Colors.white,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Icon(
                  Icons.person,
                  color: currentIndex == 2 ? accentColor : Colors.white,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
