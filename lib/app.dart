import 'package:flutter/material.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/presentation/pages/detail_page.dart';
import 'package:movierse/presentation/pages/home_page.dart';
import 'package:movierse/presentation/pages/main_page.dart';

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
    return MaterialApp(
      title: 'Movierse',
      theme: ThemeData.dark().copyWith(
        colorScheme: colorScheme,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: textTheme,
      ),
      home: body(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case MAIN_ROUTE:
            return MaterialPageRoute(builder: (_) => MainPage());
          case DETAIL_MOVIE_ROUTE:
            return MaterialPageRoute(builder: (_) => DetailPage());
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
    );
  }

  body() {
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
